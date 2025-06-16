# rocket_app_flutter

**01/02**

15:45
- Olá Reinan ou qualquer outro Dev, espero que este manual o encontre bem. <br>
Estamos aqui para orientar você no desenvolvimento de Apps em Flutter.<br>
Desda configuração de seu ambiente (pesado e denso ambiente) até o seu upload<br> 
na Loja ou build para Web.<br>
É comum pensar que seja algo fácil, mas não é.
O desenvolvimento Flutter para App foi o primeiro FrameWork a nos garantir o nosso primeiro upload de um App para uma loja (o schedule Rocket para a Play Store) e por conta disso, ele é nossa opção de desenvolvimento atual.<br>
Como ele foi o primeiro, nada melhor do que ser ele a receber esse manual em seu readme.<br>
Sem mais enrolação, vamos começar!<br>
Instale o flutter pelo snap:
<br>
```sh
sudo snap install flutter --classic
```

## 1 - Criando e Configurando o ambiente

### 1.1 - Instalando o JDK-11

```sh
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-11-jdk
```

Depois disso, você deve ter um caminho anotado de sua versão jdk atual. Por exemplo:<br>
```sh
/usr/lib/jvm/java-11-openjdk-amd64
```
Copie ele, pois será usado em breve.


### 1.2 - Instalando e Configurando o AndroidStudio

Link de [Download]('https://developer.android.com/studio/?gclsrc=aw.ds&hl=pt-br' "download AS")

Depois de baixado, coloque o seguinte codigo em seu ```.zshrc``` ou ```.bashrc```:
<br>

```sh
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/android-studio/bin
```

Note, que o caminho JDK foi colado ali no JAVA_HOME. Se for outro, então coloque outro. <br>
E sim, a gente adiantou um pouco o trabalho com o Flutter.<br>

Instale o AndroidStudio no caminho ~/, como já está configurado no código acima.<br>

inicie ele com ```studio.sh``` <br>

faça os comandos básicos e vá para a tela inicial do app.<br>
Deve aparecer isso:
<img src="https://react-native.rocketseat.dev/images/android/android-studio-menu.png">

Vá em mais ações.<br>

Instale os sdk mais atuais e o sdk cmd, como aparece na imagem abaixo:
<img src="https://cdn1.gnarususercontent.com.br/1/1116100/a97bac96-220b-4b5d-a078-f872aaed2715.png">

Feche o AntroidStudio.<br>

### 1.3 - Instalando e Configurando o Flutter:

Para baixar o Flutter para Linux, clique [aqui]('https://docs.flutter.dev/get-started/install/linux' 'flutter download')<br>

depois disso, descompacte ele no caminho ~/, como já tinha sido configurado no código de ambiente.<br>
em seguida, dê o comando ```flutter precache```. Espere.<br>
em seguida, instale os seguintes apt:

```
sudo apt-get install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
```

Depois disso, rode o comando ```flutter doctor``` e veja o que aparece.<br>
O unico erro que deve aparecer é o de licença do Android Studio. Então para aceitar , <br> rode ```flutter doctor --android-licenses``` e aceite todas.<br>

Depois disso, rode o ```flutter-doctor``` de novo. Todos deverão está com o V de ok, sem nenhuma issue.

<br>

## 2 - Iniciando o Projeto pelo VS Code.

Para iniciar o repositório de um novo App Flutter é muito fácil:<br><br>
    
    1. Digite Ctrl+Shift+P
    2. Digite Flutter
    3. Escolha Application
    4. Escreva o nome do projeto

Pronto. Repositório criado com todos os Arquivos. <br>

## 3 - Atualizando e Instalando Pacotes

Para instalar algum modulo, vá em ```pubspec.yaml```, na parte de <br>
```Dependencies``` e coloque o nome do modulo que quer adicionar. Exemplo: <br>

```yaml
dependencies:

  flutter_native_splash: ^2.2.16
  flutter:
    sdk: flutter
  footer: ^0.0.4
```

Em seguida, rode ```flutter pub get``` no terminal.<br>

Para atualizar, ```flutter pub upgrade```.


<br>

## 4 Para Rodar a Aplicação.

Simples! <br>

```sh
flutter run
```
E escolha o Device que irá rodar ela.

<br>

## 5 - Build da Aplicação.
<hr>
<br>

#### 16/06/25
agora tem como instalar ambos pelo snap
```sh
sudo snap install flutter --classic 
sudo snap install android-studio --classic
```