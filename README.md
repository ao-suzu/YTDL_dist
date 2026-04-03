# YT Downloader - Chrome拡張機能

YouTubeの動画・音楽をローカルにダウンロードするChrome拡張機能。  
Chrome Native Messaging を使ってローカルの `yt-dlp` を呼び出す仕組みだよ。

---

## フォルダ構成

```
extension//          ← Chrome拡張機能（これをChromeに読み込む）
├── manifest.json
├── panel.html / panel.js
├── content.js
├── background.js
└── icons/

host/               ← Native Messaging Host
├── host.py         ← Pythonブリッジ本体
├── host_manifest.json  ← テンプレート（install.batが使う）
├── ffmpeg.exe      ← コピー済み
├── yt-dlp.exe      ← install.bat実行時に自動DLも可
└── install.bat     ← 初回セットアップ用
```

---

## セットアップ手順

### 1. Chrome に拡張機能を読み込む

1. Chromeで `chrome://extensions/` を開く
2. 右上の「デベロッパーモード」をONにする
3. 「パッケージ化されていない拡張機能を読み込む」をクリック
4. `extension/` フォルダを選択
5. **表示された「拡張機能ID」（32文字）をコピーしておく**

### 2. Native Host をインストール

1. `host/install.bat` をダブルクリック
2. 拡張機能IDを入力（yt-dlpがなければ自動でダウンロードする）
3. 完了したらChromeを再起動

### 3. 使い方

1. YouTubeの動画ページを開く
2. 拡張機能アイコンをクリック
3. 形式（MP3/MP4など）と品質を選ぶ
4. 保存先フォルダを入力（空欄なら `~/Downloads`）
5. 「ダウンロード」ボタンをクリック！

---

## 依存ツール

| ツール | 場所 |
|--------|------|
| Python 3.x | PATH に通っていること |
| yt-dlp.exe | `host/` に配置（install.bat で自動DLも可） |
| ffmpeg.exe | `host/` に配置済み（web/からコピー） |