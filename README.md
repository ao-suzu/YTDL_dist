# YT Downloader - Chrome拡張機能

YouTubeの動画・音楽をローカルにダウンロードするChrome拡張機能。  
Chrome Native Messaging を使ってローカルの `yt-dlp` を呼び出す仕組みだよ。

---

## フォルダ構成

```text
extension/          ← Chrome拡張機能（これをChromeに読み込む）
├── manifest.json
├── panel.html / panel.js
├── background.js
└── ...

host/               ← バックグラウンド処理を行う実行ファイル
├── host.exe        ← 通信とダウンロード制御
├── yt-dlp.exe      ← YouTubeダウンロードのコア
└── ffmpeg.exe      ← 音声・動画変換ツール

install.bat         ← 初回セットアップ用スクリプト
```

---

## セットアップ手順

### 1. Chrome に拡張機能を読み込む

1. Chromeで `chrome://extensions/` を開く
2. 右上の「デベロッパーモード」をONにする
3. 「パッケージ化されていない拡張機能を読み込む」をクリック
4. `extension/` フォルダを選択
5. **表示された「拡張機能ID」（32文字）をコピーしておく**

### 2. バックグラウンド連携の設定 (install.bat)

1. このフォルダ（`dist`）内の `install.bat` をダブルクリック
2. 黒い画面が開いたら、さきほどコピーした拡張機能IDを貼り付けてEnterを押す
3. 完了したらChromeを再起動

### 3. 使い方

1. YouTubeの動画ページを開く
2. 拡張機能アイコンをクリック
3. 形式（MP3/MP4など）と品質を選ぶ
4. 保存先フォルダを入力（空欄なら `~/Downloads`）
5. 「ダウンロード」ボタンをクリック！

---

## 依存ツール・環境

| ツール       | 場所                 |
| ------------ | -------------------- |
| yt-dlp.exe   | `host/` に配置済み   |
| ffmpeg.exe   | `host/` に配置済み   |

※ この配布版(dist)はPythonのインストール不要で動作します。