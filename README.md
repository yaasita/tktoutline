
# tktoutline (テキトーアウトライン)

## これは何？

文章をアウトライン表示します
pukiwiki用に作りましたが、その他のファイルタイプにも使えます

## インストール

vundleで管理されている場合は以下を.vimrcに追加後に`:BundleInstall`でインストールされます

    Bundle 'yaasita/tktoutline'

NeoBundleの方は以下を.vimrcに追加後`:NeoBundleInstall`でインストールできます

    NeoBundle 'yaasita/tktoutline'


手動で入れる場合はファイル一式を‾/.vimにコピーします

    ~/.vim
        |_ doc
        |_ ftdetect
        |_ plugin
        |_ syntax

## 使い方

以下のコマンドで実行現在開いているバッファのアウトラインが表示されるはずです

    :TktOutline

## ヘルプ

    :h tktoutline.txt@ja

## その他

設定を行うことで、デフォルトのアウトライン表示を変更したり、
対応していない文章にも適用できます

表示サンプル  
https://github.com/yaasita/tktoutline/wiki
