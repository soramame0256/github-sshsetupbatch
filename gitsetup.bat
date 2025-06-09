@echo off
echo git�̃Z�b�g�A�b�v���J�n���܂��B
echo ��ʂ̎w���ɏ]���Đݒ���s���Ă��������B
echo --�������͂ő��s--
pause>nul
cls
echo SSH�L�[�̃Z�b�g�A�b�v���J�n���܂��B
cd %USERPROFILE%>nul
mkdir .ssh>nul
cd .ssh>nul
if exist id_rsa (
    echo SSH�L�[�����ɑ��݂��܂��B
    echo SSH�ݒ���X�L�b�v���܂��B
    goto skipSshSetup
)
:continue1
echo Enter file in which to save the key (%CD%/id_rsa): �ƕ\�����ꂽ��A�u�������͂����v�G���^�[�������Ă��������B
echo ���̌�A�p�X���[�h����͂��Ă��������B���̎��\������܂��񂪓��͂͂���Ă��܂��B
echo �G���^�[�������ƍēx���͂����߂���̂œ����p�X���[�h����͂��Ă��������B
ssh-keygen -t rsa
echo +--[RSA 3072]----+ ���܂�randomart image���\������Ă��܂���?
echo �\������Ă��Ȃ��ꍇ��no����͂��Ă��������B�\������Ă���΂��̂܂܃G���^�[�������Ă��������B
set /p check=""
if "%check%"=="no" goto continue1
:skipSshSetup
echo SSH�L�[�̐������������܂����B
echo --�������͂ő��s--
pause>nul
cls
echo SSH���J����Github�ɓo�^���܂��B
echo �ȉ���ssh-rsa����n�܂�e�L�X�g���R�s�[���Ă��������B
type id_rsa.pub
echo �R�s�[�����������牽���L�[����͂��Ă��������B
pause>nul
echo �u���E�U���J���܂��B
echo ����chrome���C���X�g�[������Ă��Ȃ����A�����͕ʂ̃u���E�U���g�p���Ă���ꍇ�͎���url�����̃u���E�U�ŊJ���Ă��������B
echo https://github.com/settings/keys
echo �J���ꂽ�y�[�W�̉E��ɂ���New SSH key���N���b�N���Ă��������B
echo �J�ڂ�����̃y�[�W��Title�ɂ͓K���Ȗ��O����͂��Ă��������B
echo Key type�ɂ�Authentication Key, Key�ɂ͐�قǃR�s�[�����e�L�X�g��\��t���Ă��������B
echo ���̌�AAdd SSH key���N���b�N���Ă��������B
start chrome "https://github.com/settings/keys"
echo ���������牽���L�[�������Ă��������B
pause>nul
echo SSH�L�[�̓o�^���������܂����B
echo �ݒ�̊m�F���s���܂��B
echo ����Are you sure you want to continue connecting (yes/no/[fingerprint])?�ƕ\�����ꂽ�ꍇ��yes�Ɠ��͂��Ă��������B
echo -----------------
ssh -T git@github.com
echo -----------------
echo Hi ���[�U�[��!����n�܂郁�b�Z�[�W���\�������ΐ����ł��B
echo ����git@github.com: Permission denied (publickey).�ƕ\�����ꂽ�ꍇ�͐ݒ肪��肭�����Ă��Ȃ��\��������܂��B
echo ���̏ꍇ�͏��߂����蒼���Ă��������B
echo --�������͂ő��s--
pause>nul
cls
echo Git�̐ݒ���J�n���܂��B
winget show Git.Git| find "Git">nul
if %errorlevel% EQU 0 goto skipInstallGit
:continue2
echo Git�̃C���X�g�[�����s���܂��B
echo ���[�U�[�A�J�E���g����̊m�F���\�����ꂽ�ꍇ�A�͂���I�����Ă��������B
echo --�������͂ő��s--
pause
winget install -h --accept-source-agreements --accept-package-agreements Git.Git
winget show Git.Git| find "Git">nul
if %errorlevel% EQU 0 goto skipInstallGit
echo Git�̃C���X�g�[���Ɏ��s���܂����B������x���s���܂��B
goto continue2
:skipInstallGit
echo Git�̃R���t�B�O�ݒ���s���܂��B
set /p gitUserName="Github�̃A�J�E���g������͂��Ă�������:"
echo chrome���g�p���ău���E�U���J���܂��B
echo ����chrome���C���X�g�[������Ă��Ȃ����A�����͕ʂ̃u���E�U���g�p���Ă���ꍇ�͎���url�����̃u���E�U�ŊJ���Ă��������B
echo https://github.com/settings/emails
echo �J���ꂽ�y�[�W�����ɃX�N���[�����AKeep my email addresses private�Ƀ`�F�b�N�����A�`�F�b�N����ꂽ�ꏊ�̉��ɋL������Ă���We'll remove your ~~ and use [�A�h���X] when performing ~ �̃A�h���X�������R�s�[���Ă��������B
echo --�������͂ő��s--
pause>nul
start chrome "https://github.com/settings/emails"
echo �R�s�[�����������牽���L�[����͂��Ă��������B
pause>nul
set /p gitEmail="�E�N���b�N���ă��[���A�h���X��\��t���Ă��������B"
echo Git�̃R���t�B�O��ύX���܂��B
echo �����̐ݒ���o�͂��܂��B
echo ���������\������Ȃ��ꍇ�́A�ݒ肪����Ă��Ȃ���Ԃł���̂Őݒ肪�K�{�ł��B
echo user.name�͈ȉ��̗l�ɐݒ肳��Ă��܂��B
git config --global user.name
echo user.email�͈ȉ��̗l�ɐݒ肳��Ă��܂��B
git config --global user.email
echo �ݒ��ύX���܂���?
set /p changeConfig="�ύX����ꍇ��yes����͂��Ă��������B�ύX���Ȃ��ꍇ�͉������͂����G���^�[�������Ă��������B"
if NOT "%changeConfig%"=="yes" goto skipGitConfigChange
echo �ݒ��ύX���܂��B
@echo on
git config --global user.name %gitUserName%
git config --global user.email %gitEmail%
@echo off
echo �ݒ��ύX���܂����B
:skipGitConfigChange
echo ��{�ݒ肪�������܂����B����ꂳ�܂ł����B
echo --�������͂ŏI��--
pause>nul
cls
exit