import { Timestamp } from "firebase-admin/firestore";

export interface WifiMeasurementResult {
    bufferbloatValue: number;
    createdAt: Timestamp;
    downloadSpeedMbps: number;
    latencyValue: number;
    placeId: string;
    ssid: string;
    terminalTime: Timestamp;
    uid: string;
    uploadSpeedMbps: number;
    usrISP: string;
}
