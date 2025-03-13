# HSP3Dish for iOS のビルドテスト

2025/03/10 ~ 2025/03/13 に色々と試行錯誤した結果を置いています

## How to build HSP3Dish app on Github Actions?

新規に XCode プロジェクトを作成してビルドする場合、以下の手順を実行する必要があります。

- `<HSP3のインストールディレクトリ>/ios/` にある `iHSP30` ではなく、このリポジトリにある `iHSP30` を使用する
- `<プロジェクト名>/hspproj.xcodeproj/project.pbxproj` を、以下のように改変する
  - すべての `IPHONEOS_DEPLOYMENT_TARGET` を `12.0` に設定する
- `<プロジェクト名>/hspproj/AppDelegate.m` を、以下のように改変する
  - 55 行目と 80 行目の
    ```ObjectiveC
    HspView* view = (HspView *)[hsp originalContentView];
    ```
    を
    ```ObjectiveC
    HspView* view = (HspView *)hsp.view;
    ```
    に置き換える
- `.github/workflows/ios.yml` を、以下のように改変する
  - `projectName: xxxx~~~` となっているところを、`projectName: <プロジェクト名>` に変更する

この手順をすべて踏み、Github にコミット＆プッシュすることで、.ipa がビルドされます。  
ただし、生成された `.ipa` は署名されていないため、AppStore に公開したり、AltStore を使わずにインストールするには `.github/workflows/ios.yml` を編集する必要があります。

## Q & A

### Q. Google AdMob に対応することはできますか。

A. 理論上は可能です。 ...理論上は。  
こちらでも Google AdMob に対応してみようと試行錯誤してみましたが、うまくいきませんでした。  
もしかしたら今ならうまくいくかもしれません~~が、体力がもうないですすみません許してくださいお願いします~~

### Q. HSP3 のドキュメントには iOS が http 系命令に対応しているという記述はないのですが、対応していますか。

A. 内部処理を確認してきました！対応しているようです

### Q. このコードを使っても、ビルドがうまくいきません。

A. [@Fng1Popn](https://x.com/Fng1Popn) か Discord `@nennneko5787` まで連絡してください。

## なぜここまで時間がかかってしまったのか

- 1 日 PC を触れなかった時間があった
- まともな開発環境がなかったため、コードの把握に時間がかかった
- xcode 系のコマンドをすべて ChatGPT にぶん投げていたため、`iphonesimurator`でビルドしていたためにライブラリが欠損していたのに気づくのに時間がかかった
- `HSPViewController`及び`AppDelegate`が廃止された`iAd`に依存していたため、コードの組み直しに時間がかかった

...はい。すみません
