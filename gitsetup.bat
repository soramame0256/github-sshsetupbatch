@echo off
echo gitのセットアップを開始します。
echo 画面の指示に従って設定を行ってください。
echo --何か入力で続行--
pause>nul
cls
echo SSHキーのセットアップを開始します。
cd %USERPROFILE%>nul
mkdir .ssh>nul
cd .ssh>nul
if exist id_rsa (
    echo SSHキーが既に存在します。
    echo SSH設定をスキップします。
    goto skipSshSetup
)
:continue1
echo Enter file in which to save the key (%CD%/id_rsa): と表示されたら、「何も入力せず」エンターを押してください。
echo その後、パスワードを入力してください。この時表示されませんが入力はされています。
echo エンターを押すと再度入力を求められるので同じパスワードを入力してください。
ssh-keygen -t rsa
echo +--[RSA 3072]----+ を含むrandomart imageが表示されていますか?
echo 表示されていない場合はnoを入力してください。表示されていればそのままエンターを押してください。
set /p check=""
if "%check%"=="no" goto continue1
:skipSshSetup
echo SSHキーの生成が完了しました。
echo --何か入力で続行--
pause>nul
cls
echo SSH公開鍵をGithubに登録します。
echo 以下のssh-rsaから始まるテキストをコピーしてください。
type id_rsa.pub
echo コピーが完了したら何かキーを入力してください。
pause>nul
echo ブラウザを開きます。
echo もしchromeがインストールされていないか、或いは別のブラウザを使用している場合は次のurlをそのブラウザで開いてください。
echo https://github.com/settings/keys
echo 開かれたページの右上にあるNew SSH keyをクリックしてください。
echo 遷移した後のページでTitleには適当な名前を入力してください。
echo Key typeにはAuthentication Key, Keyには先ほどコピーしたテキストを貼り付けてください。
echo その後、Add SSH keyをクリックしてください。
start chrome "https://github.com/settings/keys"
echo 完了したら何かキーを押してください。
pause>nul
echo SSHキーの登録が完了しました。
echo 設定の確認を行います。
echo もしAre you sure you want to continue connecting (yes/no/[fingerprint])?と表示された場合はyesと入力してください。
echo -----------------
ssh -T git@github.com
echo -----------------
echo Hi ユーザー名!から始まるメッセージが表示されれば成功です。
echo もしgit@github.com: Permission denied (publickey).と表示された場合は設定が上手くいっていない可能性があります。
echo その場合は初めからやり直してください。
echo --何か入力で続行--
pause>nul
cls
echo Gitの設定を開始します。
winget show Git.Git| find "Git">nul
if %errorlevel% EQU 0 goto skipInstallGit
:continue2
echo Gitのインストールを行います。
echo ユーザーアカウント制御の確認が表示された場合、はいを選択してください。
echo --何か入力で続行--
pause
winget install -h --accept-source-agreements --accept-package-agreements Git.Git
winget show Git.Git| find "Git">nul
if %errorlevel% EQU 0 goto skipInstallGit
echo Gitのインストールに失敗しました。もう一度実行します。
goto continue2
:skipInstallGit
echo Gitのコンフィグ設定を行います。
set /p gitUserName="Githubのアカウント名を入力してください:"
echo chromeを使用してブラウザを開きます。
echo もしchromeがインストールされていないか、或いは別のブラウザを使用している場合は次のurlをそのブラウザで開いてください。
echo https://github.com/settings/emails
echo 開かれたページを下にスクロールし、Keep my email addresses privateにチェックを入れ、チェックを入れた場所の下に記入されているWe'll remove your ~~ and use [アドレス] when performing ~ のアドレス部分をコピーしてください。
echo --何か入力で続行--
pause>nul
start chrome "https://github.com/settings/emails"
echo コピーが完了したら何かキーを入力してください。
pause>nul
set /p gitEmail="右クリックしてメールアドレスを貼り付けてください。"
echo Gitのコンフィグを変更します。
echo 既存の設定を出力します。
echo もし何も表示されない場合は、設定がされていない状態であるので設定が必須です。
echo user.nameは以下の様に設定されています。
git config --global user.name
echo user.emailは以下の様に設定されています。
git config --global user.email
echo 設定を変更しますか?
set /p changeConfig="変更する場合はyesを入力してください。変更しない場合は何も入力せずエンターを押してください。"
if NOT "%changeConfig%"=="yes" goto skipGitConfigChange
echo 設定を変更します。
@echo on
git config --global user.name %gitUserName%
git config --global user.email %gitEmail%
@echo off
echo 設定を変更しました。
:skipGitConfigChange
echo 基本設定が完了しました。お疲れさまでした。
echo --何か入力で終了--
pause>nul
cls
exit