import axios from "axios";
import * as firebaseAdmin from "firebase-admin";
import * as functions from "firebase-functions";
import { Bax } from "./bax";
import { WifiMeasurementResult } from "./wifi_measurement_result";

/**
 * Firestore Admin SDK の初期化
 */
firebaseAdmin.initializeApp();

const SLACK_WEBHOOK_URL = functions.config().slack.webhook_url;

/// BAXのcollectionのdoc作成でトリガーする
export const sendNotificationToSlack = functions.firestore
  .document("bax/{baxId}")
  .onCreate(async (snapshot, _) => {
    const bax = snapshot.data() as Bax;
    const baxReasons = bax.baxReasons;
    const firstReason = baxReasons[0];
    const text = firstReason.text;
    const point = firstReason.point;

    // baxを使った場合のみ通知したいので、プラスのpointの時はreturnする
    if (point > 0) {
      return;
    }

    // Slackに送信するメッセージを作成
    const message = `💰 BAX取引:\n ${text}\n${point}BAX`;

    try {
      // Slackに通知を送信
      await axios.post(SLACK_WEBHOOK_URL, {
        text: message,
      });
      console.log("bax-slack通知が送信されました");
    } catch (error) {
      console.error("bax-slack通知の送信に失敗しました:", error);
    }
  });

/// wifiが計測されたらトリガーする
export const sendMeasureWiFiNotificationToSlack = functions.firestore
  .document("wifiMeasurementResult/{resultId}")
  .onCreate(async (snapshot, _) => {
    const result = snapshot.data() as WifiMeasurementResult;
    const placeId = result.placeId;
    const ssid = result.ssid;
    const downloadSpeedMbps = result.downloadSpeedMbps;
    const uploadSpeedMbps = result.uploadSpeedMbps;

    const googleMapURL = `https://www.google.com/maps/search/?api=1&query=bax&query_place_id=${placeId}&hl=ja`;

    // Slackに送信するメッセージを作成
    const message = `📱 BAX計測\nssid: ${ssid}\nDownload: ${downloadSpeedMbps}\nUpload: ${uploadSpeedMbps}\n${googleMapURL}`;

    try {
      // Slackに通知を送信
      await axios.post(SLACK_WEBHOOK_URL, {
        text: message,
      });
      console.log("wifi-slack通知が送信されました");
    } catch (error) {
      console.error("wifi-slack通知の送信に失敗しました:", error);
    }
  });
