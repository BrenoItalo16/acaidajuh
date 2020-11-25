import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onCall((data, context) => {
  return {data: "Hellow from Cloud Functions!!!"};
});

export const getUserData = functions.https.onCall( async (data, context) => {
    if(!context.auth){
        return {
            "data": "Nenhum usuário logado"
        };
    }

    console.log(context.auth.uid);

    const snapshot = await admin.firestore().collection("users").doc(context.auth.uid).get();

    console.log(snapshot.data());

    return {
        "data": snapshot.data()
    };
}); 

export const addMessage = functions.https.onCall(async (data, context) => {
    console.log(data);

    const snapshot = await admin.firestore().collection("messages").add(data);
    
    return {"success": snapshot.id};
});

export const onNewOrder = functions.firestore.document("/orders/{orderId}").onCreate(async (snapshot, context) => {
    const orderId = context.params.orderId;
    
    const querySnapshot = await admin.firestore().collection("admins").get();
    
    const admins = querySnapshot.docs.map(doc => doc.id);
    let adminsTokens: string[] = [];
    for(let i = 0; i < admins.length; i++){
        const tokensAdmins: string[] = await getDeviceToken(admins[i]);
        adminsTokens = adminsTokens.concat(tokensAdmins);
    }

    await sendPushFCM(
        adminsTokens,
        'Novo Pedido',
        'Nova venda realizada. Pedido: ' + orderId
    )
});

const orderStatus = new Map([
    [0, "Cancelado"],
    [1, "Em separação"],
    [2, "Em transporte"],
    [3, "Entregue"],
])

export const onOrderStatusChanged = functions.firestore.document("/orders/{orderId}").onUpdate(async (snapshot, context) => {
    const beforeStatus = snapshot.before.data().status;
    const afterStatus =snapshot.after.data().status;

    if(beforeStatus !== afterStatus){
        const tokensUser = await getDeviceToken(snapshot.after.data().user)

        await sendPushFCM(
            tokensUser,
            'Pedido: '+ context.params.orderId,
            'Status atualizado para: '+ orderStatus.get(afterStatus),
        )
    }
})

async function getDeviceToken(uid: string){
    const querySnapshot = await admin.firestore().collection("users").doc(uid).collection("tokens").get();

    const tokens = querySnapshot.docs.map(doc => doc.id);

    return tokens;
}

async function sendPushFCM(tokens: string[], title: string, message: string){
    if(tokens.length > 0){
        const payload = {
            notification: {
                title: title,
                body: message,
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };
        return admin.messaging().sendToDevice(tokens, payload);
    }
    return;
} 