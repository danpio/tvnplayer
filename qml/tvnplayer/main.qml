import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.systeminfo 1.1


PageStackWindow {
    id: appWindow
    width: 850
    height: 480
    visible: true
    showToolBar: false
    showStatusBar: false
         color: "#000000"
    initialPage: mainPage

platformStyle:PageStackWindowStyle{

    //cornersVisible:false

}

    MainPage {
        id: mainPage
        lockInLandscape: true


    }


  ScreenSaver{
      id:wygaszacz

      screenSaverInhibited:true
  }



    }

