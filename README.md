# koobitsflutter

koobits flutter 工程師面試專案

## 架構

- 使用 [Bloc](https://pub.dev/packages/flutter_bloc) 管理狀態變化，改變狀態時，畫面也會跟著響應。
- Mock API 規劃在 repository **GET** Question, **POST** Answer
## 畫面

- Topic Screen 為題目畫面，輸入好題目後，按下一題便會進入，結束後上傳答案，進入結果。
- Result Screen 顯示答題結果，全對或有未填答案會顯示相關訊息，填答完整，但有錯誤題目則會顯示錯誤的題目，以及正確答案。
