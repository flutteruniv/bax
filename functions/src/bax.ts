import { Timestamp } from 'firebase-admin/firestore';

export interface Bax {
    baxReasons: BaxReasons[];
    bonusRate: number;
    createdAt: Timestamp;
    uid: string;
}

interface BaxReasons {
    text: string;
    point: number;
}
