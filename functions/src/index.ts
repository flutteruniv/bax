import axios from 'axios';
import * as firebaseAdmin from 'firebase-admin';
import * as functions from 'firebase-functions';

/**
 * Firestore Admin SDK の初期化
 */
firebaseAdmin.initializeApp();

const SLACK_WEBHOOK_URL = functions.config().slack.webhook_url;

// Firestoreのリクエストコレクションに新規データが追加された時のトリガー
export const sendNotificationToSlack = functions.firestore.document('bax/{baxId}').onCreate(async (snapshot, _) => {
    // 新規データを取得
    const data = snapshot.data();
    const baxReasons = data.baxReasons;
    const firstReason = baxReasons[0];
    const text = firstReason.text;
    const point = firstReason.point;

    // Slackに送信するメッセージを作成
    const message = `BAX付与:\n ${text}\n${point}BAX`;

    try {
        // Slackに通知を送信
        await axios.post(SLACK_WEBHOOK_URL, {
            text: message,
        });
        console.log('Slack通知が送信されました');
    } catch (error) {
        console.error('Slack通知の送信に失敗しました:', error);
    }
});
