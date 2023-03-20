## 環境切り替えコマンド

```
<!-- 開発環境に切り替え -->
firebase use dev

<!-- 本番環境に切り替え -->
firebase use prod
```

## デプロイコマンド例

```
firebase deploy --only firestore:rules --project=dev
firebase deploy --only functions --project=dev
```

## 留意事項

本番環境の Cloud Firestore が Datastore モードになっているため、firestore をデプロイすることができない。
そのため本番環境には下記のコマンドは使えない。

```
firebase deploy
firebase deploy --only firestore
```
