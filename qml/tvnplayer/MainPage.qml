import QtQuick 1.1
import Qt 4.7
import com.nokia.meego 1.0
import QtMultimediaKit 1.1
import QtWebKit 1.0
import "script.js" as Script
Page {


    function httpGet(theUrl)
    {
        var xmlHttp = null;


        xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {

console.log(xmlHttp.readyState+":"+xmlHttp.responseText)

                }
xmlHttp.open( "GET", theUrl, true );
        if(xmlHttp.readyState == XMLHttpRequest.OPENED){
            xmlHttp.setRequestHeader('User-Agent','Mozilla/5.0 (SmartHub; SMART-TV; U; Linux/SmartTV; Maple2012) AppleWebKit/534.7 (KHTML, like Gecko) SmartTV Safari/534.7\r\n');


        }
xmlHttp.send();

        return xmlHttp.responseText;
    }
    function sendRequest(request) {
    var xhr2 = new XMLHttpRequest;
    xhr2.open("GET", request);
    if(xhr2.readyState == XMLHttpRequest.OPENED){
        xhr2.setRequestHeader('User-Agent','Mozilla/5.0 (SmartHub; SMART-TV; U; Linux/SmartTV; Maple2012) AppleWebKit/534.7 (KHTML, like Gecko) SmartTV Safari/534.7\r\n');
    }

    xhr2.send();
    return xhr2.statusText
    }

    function assemble_show_model()
    {
        //model_giver.clear()red
        var i = 0
        for(i=0; i<xmlModel.count; i++)
        {
            //model_giver.append({"index_g": xmlModel.get(i).id,
            //                       "text_g": xmlModel.get(i).name,
            //                   })
            console.log("id:"+xmlModel.get(i).id+" name:"+xmlModel.get(i).name+" type:"+xmlModel.get(i).type+" "+xmlModel.get(i).thumbnail)


        }
    }

    MouseArea {
        id: mouse_area6
        x: 394
        y: 292
        width: 66
        height: 38
    onClicked: {
        //getIconUrl(xmlModel)
      ////  assemble_show_model()
        applicationData.play_fullscreen()

    }

    }



    Timer {
         id: simpletimer
         interval: 5000
         repeat: false
         running: false
         onTriggered: pozycja_video_panel.opacity=-0.50
         Component.onCompleted: {
             pozycja_video_panel.visible=false

         }
     }



    Rectangle{
    id:pozycja_video_panel
    color: "#00000000"
    z: 8
    anchors.fill: parent
    visible:false

    Button {
        id: bpausa
        x: 14
        y: 425
        width: 48
        height: 48
        text: qsTr("||")
        //iconSource: "image://theme/icon-m-toolbar-mediacontrol-pause-white.png"
        //iconSource: "assets/icon_" + (pressed ? "pressed" : "normal") + ".png"

onClicked: {

    pauza()

}
    }
    Slider {
        id:pozycja_video
        x: 62
        y: 429
        width: 778
        height: 40
        stepSize:1270
        valueIndicatorVisible: true
        minimumValue:0
        maximumValue:tvn_player.duration
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.left: parent.left
        anchors.leftMargin: 62

        value: 0




        onPressedChanged: {
tvn_player.position=pozycja_video.value
simpletimer.running=true
        }

        onValueChanged: {


        }
    }




}
    BusyIndicator {
        id: indicator3
        x:143
        y:151
        width: 150
        height: 150
        //transformOrigin: QDeclarativeItem.Right
        z: 10
        //opacity: 1
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.horizontalCenter: parent.horizontalCenter
        running: true
        platformStyle: BusyIndicatorStyle {

            size: "large"
        }
        //visible: tvn_player.status==Video.Loading


    }

    property string source
    property Item player
    Component.onCompleted: tvn_player.source = source

    property string zrodlo: "TVN"
    property string query_path_var: ""
    property string query_video_var: ""
    property string select_title: ""
    property string last_source: ""
    property string last_query: ""
    property string last_m: ""
    property string last_id: ""
    property string seasons: ""
    property string play_url: ""
    property variant last_sources: []
    property variant last_querys: []
    property int  poz_tree: 0
    property int  new_poz_tree: 0

    state: (screen.currentOrientation == Screen.Portrait) ? "portrait" : "landscape"

    states: [
        State {
            name: "landscape"

            PropertyChanges {
                target: tvn_player
                x: 37
                y: 82
                width: 306
                height: 245
                anchors.horizontalCenterOffset: -237
                anchors.verticalCenterOffset: -36
            }

            PropertyChanges {
                target: listview1
                x: 478
                y: 0
                width: 376
                height: 480
                cacheBuffer: 5
                boundsBehavior: "DragAndOvershootBounds"
                snapMode: "NoSnap"
                flickableDirection: "VerticalFlick"
                visible: true
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: 239
            }

            PropertyChanges {
                target: ekran
                x: 102
                y: 52
                width: 310
                height: 247
            }

            PropertyChanges {
                target: text1
                x: 116
                y: 226
                width: 283
                height: 57
                color: "#ffffff"
                wrapMode: "WordWrap"
                font.pixelSize: 30
                font.italic: false
                font.bold: true
            }

            PropertyChanges {
                target: telewizor
                z: 4
            }





         //   PropertyChanges { target: label1; x: 20; y: 50}

        },

        State {
            name: "portrait"

          //  PropertyChanges { target: label1; x: 20; y: 200}

            PropertyChanges {
                target: listview1
                x: 0
                y: 420
                width: 370
                height: 434
                cacheBuffer: 5
                boundsBehavior: "DragAndOvershootBounds"
                flickableDirection: "VerticalFlick"
                snapMode: "NoSnap"
                flow: "LeftToRight"
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: 210
            }

            PropertyChanges {
                target: page1
                width: 480
                height: 854
            }

            PropertyChanges {
                target: tvn_player
                x: 36
                y: 40
                width: 306
                height: 245
                anchors.horizontalCenterOffset: -50
                anchors.verticalCenterOffset: -261
            }

            PropertyChanges {
                target: ekran
                x: 103
                y: 52
                width: 310
                height: 247
                fillMode: "PreserveAspectCrop"
                sourceSize.height: 600
                sourceSize.width: 600
                clip: true
            }





            PropertyChanges {
                target: text1
                x: 116
                y: 242
                width: 295
                height: 57
                color: "#ffffff"
                text: ""
                wrapMode: "WordWrap"
                horizontalAlignment: "AlignHCenter"
                verticalAlignment: "AlignVCenter"
                font.bold: true
                font.pixelSize: 30
                font.italic: false
            }

            PropertyChanges {
                target: rectangle3
                x: 198
                y: 360
            }

            PropertyChanges {
                target: listview_tmp
                x: 137
                y: 453
            }

            PropertyChanges {
                target: telewizor
                x: -68
                y: -9
                z: 4
            }














        }
    ]

    /*
def getIconUrl(self, node):
            thumbnails = node.findall('thumbnail/row')
            iconUrl = ''
            if len(thumbnails) > 0:
                icon = thumbnails[0].find('url').text.encode('utf-8')
                if dbg == 'true':
                    log.info('TVN - getIconUrl() -> url: ' + self.mediaHost + self.mediaMainUrl + icon + '?quality=70&dstw=290&dsth=187&type=1')
                iconUrl = self.mediaHost + self.mediaMainUrl + icon + '?quality=70&dstw=290&dsth=187&type=1'
            return iconUrl
*/



    function wybierz_program(id,type,name,episode,title,temp_sdt_url,title_tvp,url,query_p,query_video){
        poz_tree++
        Script.addItem(xmlModel.source,xmlModel.query,m)
            console.log('dodano do historii:\n\r s:'+xmlModel.source+"\n\r q:"+xmlModel.query+"\n\r m:"+m)
console.log('poz_tree:'+poz_tree)

        //console.log(xmlModel.get(1).title_tvp)
        console.log("zrodlo: "+zrodlo)


        text1.visible=true

        switch(zrodlo){
        case "TVP":
        {
            console.log("tvp "+url)
            //select_title=title
            if(m=='katalog'){

                //xmlModel.source="http://www.tvp.pl/pub/stat/missed?src_id=1885&object_id=-1&offset=-1&dayoffset=-1"
                m=""
                select_title=title
                listview1.model=xmlModel
                xmlModel.source=url
                xmlModel.query=query_p
                xmlModel.reload()

                xmlModel_tmp.source=url
                xmlModel_tmp.query=query_video
                xmlModel_tmp.reload()


            }else{
            //    temp_sdt_url=(xmlModel_tmp.get(id).file_name!='')?xmlModel_tmp.get(id).file_name:xmlModel_tmp.get(id).temp_sdt_url

                temp_sdt_url=xmlModel_tmp.get(id).temp_sdt_url

            if(temp_sdt_url!=''){

            console.log("play :"+temp_sdt_url)
                select_title=title_tvp

                play_url=temp_sdt_url
                play_video(temp_sdt_url)

            }else{


           // xmlModel.query=query_video
           // xmlModel.reload()
            }
}
        }
        break;
        case "TVN":
        {
            console.log(m)
            switch (m)
                               {

                                   case 'mainInfo':
                                   {

                                       if(tvn_player.playing==false){
                                       ekran.source= "tvSnow.jpg"
                                       ekran.visible=true
                                       }
                                       m="getItems"

                                       last_type=type

                                       xmlModel.source=base_url+"&m=getItems&type="+type+"&id="+id+"&limit=500&page=1&sort=newest"
                                       xmlModel.query="/Player_ApiMapper/getItems/items/row"
                                       xmlModel.reload()

                                        select_title=name

                                       console.log('mainInfo '+xmlModel.source)
                                   }
                                   break;
                                   case 'getItems':
                                   {


                                       if(type!="episode"){
                                        select_title=title
                                           m="getItem"


                                           xmlModel.source=base_url+"&m=getItems&type="+type+"&id="+id
                                           xmlModel.query="/Player_ApiMapper/getItems/items/row"
                                           xmlModel.reload()
                                           console.log(xmlModel.source)

                                       }else{
                                           xmlModel_tmp.source=base_url+"&m=getItem&type="+type+"&id="+id
                                           xmlModel_tmp.query="/Player_ApiMapper/getItem/item/videos/main/video_content/row"
                                           xmlModel_tmp.reload()

                                            console.log('boczna lista')
                                           if(episode!=0){
                                             select_title=(title+" odc. "+episode)

                                           }else{

                                               select_title=(title)

                                           }

                                       }

                                       console.log("getItems "+xmlModel.source)
                                   }
                                   break;


                                   case 'getItem':
                                   {

                                       if(episode!=0){

                                           select_title=(title+" odc. "+episode)
                                       }else{

                                           select_title=(title)

                                       }
                                       xmlModel_tmp.source=base_url+"&m=getItem&type="+type+"&id="+id
                                       xmlModel_tmp.query="/Player_ApiMapper/getItem/item/videos/main/video_content/row"
                                       xmlModel_tmp.reload()
                                       console.log("getItem: "+xmlModel.source)

                                   }
                                   break;


                                   }
        }
        break;

        }

         text1.text=(select_title)
         console.log("Wybrano: "+select_title)




    }

    function pauza(){
        console.log("pauza "+tvn_player.paused+" "+tvn_player.status)

        if(tvn_player.paused==true){

               //bpausa.iconSource="toolbar-mediacontrol-pause"
            tvn_player.play()

        }else{
        if(tvn_player.playing==true){
            //bpausa.iconSource="toolbar-mediacontrol-play"

           tvn_player.pause()
        }

        }
    }

    function lista_powrot_home(){
poz_tree=0

        Script.reset()
        m="mainInfo"
        tumb_base_url="http://dcs-188-64-84-23.atmcdn.pl/dcs/o2/tvn/web-content/m/"
        zrodlo="TVN"
        //Mobile
        //ConnectedTV
        listview1.model=xmlModel
        xmlModel.source=base_url+"&m="+m//"http://tvnplayer.pl/api/?platform="+platform+"&terminal="+terminal+"&format=xml&m=mainInfo&m="
        xmlModel.query="/Player_ApiMapper/mainInfo/categories/row"
        xmlModel.reload()

        console.log("back to :"+xmlModel.source+" "+xmlModel.query);

    }
    function lista_powrot(){
        console.log(poz_tree)
        new_poz_tree=(poz_tree-1)
        if(new_poz_tree>-1){
        //console.log("cofnij z: "+poz_tree+" do:"+new_poz_tree+" \n\r"+Script.getList()[new_poz_tree]+" \n\r"+Script.getList2()[1]+" \n\r"+Script.getlastm()[new_poz_tree])
         xmlModel.source=Script.getList()[new_poz_tree]
         xmlModel.query=Script.getList2()[new_poz_tree]
         m=Script.getlastm()[new_poz_tree]
         //m='getItems'
             poz_tree=poz_tree-1
         xmlModel.reload()
            console.log(poz_tree)
        }else{
            Script.reset()
            poz_tree=0
        }





    }
    function play_video(play_url){

    //console.log("click play url_video: "+play_url)
    tvn_player.source=play_url
    tvn_player.visible=true
    tvn_player.play()

}
    id: page1

        property string m: "mainInfo"
        property string platform:"ConnectedTV"//ConnectedTV"
        property string terminal:"Samsung"//"Samsung"
        property string authKey:"ba786b315508f0920eca1c34d65534cd"
        property string base_url: "https://api.tvnplayer.pl/api/?platform="+platform+"&terminal="+terminal+"&format=xml&v=2.0&authKey="+authKey
        property string tumb_base_url:"http://dcs-188-64-84-23.atmcdn.pl/dcs/o2/tvn/web-content/m/"
        property string url_video_to_play:""
        property string last_type: ""
//https://api.tvnplayer.pl/api/?platform=Mobile&terminal=Android&format=xml&v=2.0&authKey=b4bc971840de63d105b3166403aa1bea&m=getItem&type=episode&id=17041
        width: 854
        height: 480
        XmlListModel {
            id: xmlModel_tmp

            XmlRole { name: "url"; query: "url/string()" }
XmlRole { name: "profile_name"; query: "profile_name/string()" }
XmlRole { name: "temp_sdt_url"; query: "@temp_sdt_url/string()" }
XmlRole { name: "title_tvp"; query: "video/@hptitle/string()" }
XmlRole { name: "file_name"; query: "@file_name/string()" }
XmlRole { name: "thumbnail_tvp"; query: "image/@file_name/string()" }
        }

    XmlListModel {
        id: xmlModel

        source: base_url+"&m="+m
        query: "/Player_ApiMapper/mainInfo/categories/row"


        XmlRole { name: "id"; query: "id/string()"  }
        XmlRole { name: "id_tvp"; query: "@id/string()"  }
        XmlRole { name: "type"; query: "type/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "sub_title"; query: "sub_title/string()" }
        XmlRole { name: "lead"; query: "lead/string()" }
        XmlRole { name: "episode"; query: "episode/string()" }
        XmlRole { name: "season"; query: "season/string()" }
        XmlRole { name: "start_date"; query: "start_date/string()" }
        XmlRole { name: "end_date"; query: "end_date/string()" }
        XmlRole { name: "type_episode"; query: "type_episode/string()" }
        XmlRole { name: "serie_title"; query: "serie_title/string()" }
        XmlRole { name: "url"; query: "url/string()" }
        XmlRole { name: "url2"; query: "url/string()" }
        XmlRole { name: "url3"; query: "thumbnail/row/url/string()" }
        XmlRole { name: "thumbnail"; query: "thumbnail/row/url/string()" }
        XmlRole { name: "profile_name"; query: "profile_name/string()" }
        XmlRole { name: "url_video"; query: "url/string()" }
        XmlRole { name: "run_time"; query: "run_time/string()" }
        XmlRole { name: "temp_sdt_url"; query: "accepted_by_av/string()" }
        XmlRole { name: "title_tvp"; query: "@hptitle/string()" }

        XmlRole { name: "title2"; query: "@title/string()" }
        XmlRole { name: "thumbnail_tvp"; query: "image/@file_name/string()" }


        XmlRole { name: "file_name"; query: "@file_name/string()" }




//onCountChanged: console.log("count:", count)
onSourceChanged: {





    indicator3.visible=true;
    indicator3.running=true
}

onProgressChanged: {

    //indicator3.running=true
    //indicator3.rotation=360


//    console.log("pozycje:", progress)


}

onStatusChanged: {
    if(progress==1){

    //console.log("szukaj ikon:")

    }


}

    }





    Rectangle {
        id: rectangle1
        x: 10
        y: 14
        color: "#000000"
        z: -1
        anchors.fill: parent

        Component {

               id: highlight

               Rectangle {

                   color: "lightsteelblue"

                   radius: 5

               }

           }
        Component {
             id: appHighlight
             Rectangle { width: 80; height: 80; color: "lightsteelblue" }
         }

        ListView {
            visible:false
            id: listview_tmp
            model: xmlModel_tmp

            delegate:tvnlista_tmp
            x: 553
            y: 108
            width: 218
            height: 165



            onCountChanged: {

                if(xmlModel_tmp.count>1){
                if(zrodlo=='TVN'){

                //console.log("play first click :)"+xmlModel_tmp.get(0).url)

                 var http = new XMLHttpRequest()
                    var http2 = new XMLHttpRequest()
                var url_old=xmlModel_tmp.get(0).url
                var url_new
                var video_file
                var video_url
                var salt
                var token
                var postFields
                 var url
                http.onreadystatechange = function() {
                                   if (http.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                                   } else if (http.readyState === XMLHttpRequest.DONE) {

                                       //console.log(http.responseText)

url_new=http.responseText.substring(http.responseText.search("</html>")+7,http.responseText.length);

                                      // console.log("url_new:"+url_new)
video_url=url_new.substring(29,url_new.length)

tvn_player.source="http://dcs-188-64-84-19.atmcdn.pl/dcs/"+video_url
tvn_player.play()

//console.log("new url: http://dcs-188-64-84-19.atmcdn.pl/dcs/"+video_url)
                                   }
                               }
                        http.open("GET", url_old, true);
                    http.send()
                    tvn_player.visible=true


                    }

            }
        }
        }
        Component{
           id: tvnlista_tmp

           Text {
               id: text_w_liscie2
               x: 5
               y: 119
               width: 180
               height: 40
               font.pointSize: 12
               color: "#FFFFFF"
               text:  profile_name + url
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter


               visible: true

               wrapMode: Text.WordWrap
           }

        }
        GridView {
            cacheBuffer:5
            visible:true
            id: listview1
            opacity: -listview1.contentY > 10 ? (0.50) : 1;
                    Behavior on opacity { NumberAnimation { duration: 100  } }
            x: 470

            y: 33
cellWidth: 180; cellHeight: 163
            width: 384
            height: 332
            boundsBehavior: Flickable.DragAndOvershootBounds
            snapMode: GridView.NoSnap
            z: 0
            clip: true
            highlight: highlight
            highlightFollowsCurrentItem: false
            focus: true
            flickableDirection: Flickable.VerticalFlick
            contentWidth: 10
            anchors.horizontalCenterOffset: 235
            anchors.horizontalCenter: parent.horizontalCenter
          //  spacing: 2
            anchors.verticalCenterOffset: -41
            anchors.verticalCenter: parent.verticalCenter
            model: xmlModel

            delegate:tvnlista
           // contentY: (-listview1.contentY > 50) ? listview1.state='odswiez' : listview1.state='';

            //state: (-listview1.contentY > 50) ? 'odswiez' : 'przesuwanie';

            states: [
                 State {
                    name: "odswiez";
                     PropertyChanges { target: text1; color: "red" }
                 }
             ]

onOpacityChanged: {

    if(listview1.opacity==0.50 ){
        listview1.state='odswiez'

        text1.text="Powrot"


    }else{

        listview1.state=''
    }

}

onStateChanged: {
console.log('status: '+listview1.state)
    switch(listview1.state){
    case'odswiez':
        {


    }
        break;
    case'':

    {
        if(poz_tree>0) lista_powrot()
    }

    break;

    }


}



            }



        Component{
           id: tvnlista

           Rectangle {

               opacity: -listview1.contentY > 10 ? (0.75) : 1;
                       Behavior on opacity { NumberAnimation { duration: 100  } }



               id: rectangle2
               x:7
               y: 4
               width: 180
               height: 163
               color: "#000000"//128
               radius: 9
               border.color: "#000000"



               Image{
                   id: podglad_w_liscie
                   asynchronous: true
                              smooth: true
                   x:5
                   y:5
                   width:180
                   height:157
                   source:(thumbnail_tvp!='')?(tumb_base_url+(thumbnail_tvp.substring(0,45))+'_width_160.jpg'):( (thumbnail!='') ?(tumb_base_url+thumbnail+'?quality=70&dstw=290&dsth=187&type=1'):"tvSnow.jpg")



//
                   //source:  tumb_base_url+url2


                   Rectangle {
                       x:parent.x-6
                       y:parent.y-6
                       width:parent.width+1
                       height:parent.height+1
                       color: "#00000000"
                       border.color: "#000000"
                   radius: 9
                   border.width: 6
                   }
               }
    Rectangle{
x:5
y:119
width:parent.width
height: 40
color: "#000000"
opacity: 0.75


    }
    Text {
        id: text_w_liscie
        x: 5
        y: 119
        width: 180
        height: 40
        font.pointSize: 12
        color: "#FFFFFF"
        text:  (title_tvp!='')? title_tvp+''+title2 : (episode!='')?(title+" odc. "+episode): (name + " "+title+" "+profile_name)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter


        visible: true

        wrapMode: Text.WordWrap
    }
    Text {
        id: text_w_liscie_info

        x: 190
        y: 10
        width: parent.width
        height: 40
        font.pointSize: 10
        color: "#FFFFFF"
        text: (start_date!='') ? "odc. "+episode+"<br>dostępny<br>od "+start_date+"<br>do "+end_date+"<br>czas: "+run_time : ""


        visible: false

        wrapMode: Text.WordWrap
    }

               MouseArea{
                   id: mouse_area1
                   width: 494
                   height: 133
                   anchors.bottomMargin: 0
                   anchors.fill: parent
                   z: 2
                   hoverEnabled: false


                   onPressAndHold: {
                       text_w_liscie.scale=0.90
                       podglad_w_liscie.opacity= 0.75


                   }
                   onPressed: {

                text_w_liscie.scale=1
                podglad_w_liscie.opacity= 1
                //podglad_w_liscie.scale=1
                 rectangle2.scale=1
                       if(tvn_player.playing==false){
                           if(url2!=""){
                           ekran.source=tumb_base_url+url2
                        }else{
                               ekran.source="tvSnow.jpg"
                           }
}
                   }
                   onPressedChanged: {

                       if(podglad_w_liscie.opacity==1){
                           podglad_w_liscie.opacity= 0.75
      //                     text_w_liscie.scale=0.75
       //                    podglad_w_liscie.scale=0.75
                           rectangle2.scale=0.90
                       }else{
//                           text_w_liscie.scale=1
 //                          podglad_w_liscie.scale=1

                           podglad_w_liscie.opacity= 1
                           rectangle2.scale=1
                       }


                              if(tvn_player.playing==false){
                                  if(url2!=""){
                                  ekran.source=tumb_base_url+url2
                               }else{
                                      ekran.source="tvSnow.jpg"
                                  }
       }

                      // console.log('przycisinieto '+id)
                   }


onContainsMouseChanged: {
    //text_w_liscie.scale=0.9
    //podglad_w_liscie.opacity= 0.75

}
                   onMouseYChanged: {
                       if(url2!=''){
                           text_w_liscie.scale=1
                           podglad_w_liscie.opacity= 1
                       }
                   }
                   onClicked: {
  //                     podglad_w_liscie.opacity= 0.75
  //                     rectangle2.scale=0.90

                       if(zrodlo=='TVP'){
                     //      console.log('pozycja'+index)
                           if(query_path_var==''){

                               query_path_var=query_path;
                               query_video_var=query_video;
                           console.log("1234 "+query_video)
                           }

                           wybierz_program(index,type,name,episode,title,temp_sdt_url,title_tvp,url,query_path_var,query_video_var)
                       }else{
                           wybierz_program(id,type,name,episode,title,temp_sdt_url,title_tvp,url,'query','query_video')

                       }


                   }
               }
               Component.onCompleted: {
                   indicator3.visible=false;
                   indicator3.running=false;
               }
           }
        }
}

Image {
    id: telewizor
    x: -68
    y: 29
    width: 616
    height: 355
    clip: true
    z: 4
    source: "tv-139183.png"

    Image {
        id: ekran
        x: 102
        y: 52
        width: 310
        height: 247
        sourceSize.height: 0
        sourceSize.width: 0
        z: -2
        source: "tvSnow.jpg"

        MouseArea {
            id: mouse_area3
            anchors.fill: parent
            onClicked: {
                play_video(play_url)




            }
        }

    }



    Rectangle {
        id: rectangle4
        x: 455
        y: 47
        width: 70
        height: 97
        color: "#FFFFFF"
        opacity: 0
        MouseArea {
            id: mouse_area4
            x: -6
            y: -6
            width: 82
            height: 109
            anchors.rightMargin: -6
            anchors.bottomMargin: -5
            anchors.leftMargin: -6
            anchors.topMargin: -6
            anchors.fill: parent
            onClicked: {

                pauza()
//lista_powrot()

            }

        }
    }

    Text {
        id: text1
        x: 93
        y: 255
        width: 330
        height: 44
        text: qsTr("")
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.italic: false
        font.pixelSize: 30
    }

    Text {
        id: text2
        x: 455
        y: 169
        width: 33
        height: 29
        color: "#11ff00"
        text: tvn_player.status
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }
    Rectangle {
        id: rectangle3
        x: 198
        y: 360
        width: 65
        height: 65
        color: "#00000000"
        Image {
            id: logo_tvn
            anchors.fill: parent
            source: "tvn-logo.png"
            opacity: 1
        MouseArea {
            id: mouse_area2
            anchors.fill: parent
               onClicked: {
                   logo_tvn.opacity=1
                   logo_tvp.opacity=0.5

               lista_powrot_home()
               }

        }
    }

    }

    Rectangle {
        x: 298
        y: 360
        width: 65
        height: 65
color: "#00000000"
Image {
    id: logo_dbox
    anchors.fill: parent
    source: "dbox2.png"
    opacity: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
telewizor.z=4
ekran.visible=false

                var http = new XMLHttpRequest()
                var url_old="http://192.168.100.66/control/zapto?getpids"
                var url_new
                http.onreadystatechange = function() {
                                   if (http.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                                   } else if (http.readyState === XMLHttpRequest.DONE) {
                                        url_new=http.responseText
                                      console.log("PID:"+url_new)

                                       applicationData.seturl(url_new)
                                       applicationData.play(view)

                                   }
                               }
                        http.open("GET", url_old, true);

                http.send()





            }
        }
    }
Image {
    id: logo_dream
    anchors.fill: parent
    source: "dbox2.png"
    opacity: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
telewizor.z=4
ekran.visible=false

                var http = new XMLHttpRequest()
                var url_old="http://192.168.100.65/control/zapto?getpids"
                var url_new
                http.onreadystatechange = function() {
                                   if (http.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                                   } else if (http.readyState === XMLHttpRequest.DONE) {
                                        url_new=http.responseText
                                      console.log("PID:"+url_new)

                                       applicationData.seturl(url_new)
                                       applicationData.play(view)

                                   }
                               }
                        http.open("GET", url_old, true);

                http.send()





            }
        }
    }


}





    ListModel {
        id: tvp_katalog

        ListElement {thumbnail_tvp:"";title: "Przegapiłeś";url: "http://www.tvp.pl/pub/stat/missed?src_id=1885&object_id=-1&offset=-1&child_mode=SIMPLE&dayoffset=-1&rec_count=";query_path:"/portal_document/epg_item/video";query_video:"/portal_document/epg_item/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:"";temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Najcześciej oglądane";url: "http://www.tvp.pl/pub/stat/videolisting?src_id=1885&object_id=929547&object_type=video&child_mode=SIMPLE&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:""; thumbnail: "";profile_name:""; start_date:"";url2:"";type:"";title_tvp:"";episode:"";temp_sdt_url:"";name: ""}
        ListElement {thumbnail_tvp:"";title: "Makłowicz w podróży";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=1364&with_subdirs=true&sort_desc=true&sort_by=RELEASE_DATE&child_mode=SIMPLE&rec_count=";title_tvp:"";query_path:"/portal_document/directory_standard/video";query_video:"/portal_document/directory_standard/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:"";temp_sdt_url:"";name: ""}
        ListElement {thumbnail_tvp:"";title: "Kabarety";query_path:"/portal_document/directory_standard/video";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=883&with_subdirs=true&sort_desc=true&sort_by=RELEASE_DATE&child_mode=SIMPLE&rec_count=";query_video:"/portal_document/directory_standard/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:"";temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Sport najnowsze";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=1775930&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Sport teraz oglądane";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=928060&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Sport najwyżej oceniane";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=928062&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Sport najczęściej oglądane";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=928059&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Kraków top";url: "http://www.tvp.pl/pub/stat/videolisting?src_id=1885&object_id=929711&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Krakow kronika";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=1277349&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_standard/video";query_video:"/portal_document/directory_standard/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:"";temp_sdt_url:"";name: "";title_tvp:"";}

        ListElement {thumbnail_tvp:"";title: "Wrocław top";url: "http://www.tvp.pl/pub/stat/videolisting?src_id=1885&object_id=929711&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
ListElement {thumbnail_tvp:"";title: "Wrocław FAKTY";url: "http://www.tvp.pl/pub/stat/videolisting?src_id=1885&object_id=929711&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_stats/video";query_video:"/portal_document/directory_stats/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:""; temp_sdt_url:"";name: "";title_tvp:""}
        ListElement {thumbnail_tvp:"";title: "Wrocław rozmowy faktow";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=1853619&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/directory_standard/video";query_video:"/portal_document/directory_standard/video/video_format";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:"";temp_sdt_url:"";name: "";title_tvp:"";}


        //ListElement {thumbnail_tvp:"";title: "Wszystko";url: "http://www.tvp.pl/pub/stat/videolisting?object_id=5&object_type=video&child_mode=SIMPLE&sort_by=RELEASE_DATE&sort_desc=true&rec_count=";query_path:"/portal_document/vortal/directory_standard/directory_standard";query_video:"/portal_document/directory_standard/video";file_name:"";thumbnail: "";profile_name:"";start_date:"";url2:"";type:"";episode:"";temp_sdt_url:"";name: "";title_tvp:"";}

    }

    Rectangle {
        id: rectangle5
        x: 93
        y: 360
        width: 65
        height: 65
        color: "#00000000"
        radius: 4
        z: 0
        Image {
            id: logo_tvp
            anchors.fill: parent
            source: "logo_tvp.png"
            opacity: 0.5
            MouseArea {
                id: mouse_area5
                anchors.fill: parent
                onClicked: {
                    logo_tvn.opacity=0.5
                    logo_tvp.opacity=1
                    query_path_var=""
                    zrodlo="TVP";
listview1.model=tvp_katalog
                    indicator3.running=false
                    indicator3.visible=false
                    m="katalog"


tumb_base_url="http://s.v3.tvp.pl/images/6/2/4/uid_"
                    //_width_160.jpg


                //    xmlModel.source="http://www.tvp.pl/pub/stat/missed?src_id=1885&object_id=-1&offset=-1&dayoffset=-1"
                //    xmlModel.query="/portal_document/epg_item"
                //    xmlModel.reload()



                }
            }
        }

    }



}

Video {
    id: tvn_player
    x: 34
    y: 82
    width : 306
    height : 245
    z: 1
    anchors.verticalCenterOffset: -36
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenterOffset: -237
    anchors.horizontalCenter: parent.horizontalCenter
    source: ""
    visible: false





    onStatusChanged: {

        //console.log("staus "+tvn_player.status)
        switch (tvn_player.status)
        {

        case 2:
        {
            console.log("wczytywanie "+tvn_player.status)
            ekran.source= "tvSnow.jpg"
            ekran.visible=true

            indicator3.running=true
            indicator3.visible=true

        }
        break;
        case 4:
        {
            ekran.visible=false
            console.log("buforowanie "+tvn_player.status)
            indicator3.running=true
            indicator3.visible=true

        }
        break;
        case 6:
        {
            console.log("odtwarzanie "+tvn_player.status)

            indicator3.running=false
            indicator3.visible=false

        }
        break;
        }




    }

    onError: {
        ekran.source="error.png"
        ekran.visible=true

    }

    onAutoLoadChanged: {
        indicator3.visible=true
        indicator3.running=true

    }

    onPlayingChanged: {

        text1.visible=false
        indicator3.visible=false
        indicator3.running=false
        ekran.visible=false

    }



    onPositionChanged:{

        pozycja_video.value=tvn_player.position

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {

            if(pozycja_video_panel.visible==true){
                pozycja_video_panel.opacity=1
                simpletimer.running=true

            }else{
                pozycja_video.value=tvn_player.position
                pozycja_video_panel.opacity=1
                pozycja_video_panel.visible=true
            }


        }
        onDoubleClicked: {

            if(tvn_player.z==0){
                console.log("full screen on")
rectangle1.z=1
                tlo_player.visible=true
                indicator3.x=407
                indicator3.y=240
                indicator3.width=150
                indicator3.height=150
                //BusyIndicator.visible=false
                pozycja_video.value=tvn_player.position
                pozycja_video_panel.opacity=1
                simpletimer.running=true
                pozycja_video_panel.visible=true



                screen.allowedOrientations = Screen.Landscape
                tvn_player.anchors.verticalCenterOffset=0
                tvn_player.anchors.horizontalCenterOffset=0

                tvn_player.x=-50
                tvn_player.y= -14
                tvn_player.width= 854
                tvn_player.height= 480

                tvn_player.z=2
                telewizor.visible=false
                tvn_player.play()

            }else{
                rectangle1.z=0
                tlo_player.visible=false
                console.log("full screen off")
                screen.allowedOrientations = Screen.All
                if(screen.currentOrientation == Screen.Portrait){

                    indicator3.x=143
                    indicator3.y=151
                    indicator3.width=150
                    indicator3.height=150
                    tvn_player.anchors.verticalCenterOffset=-36
                    tvn_player.anchors.horizontalCenterOffset=-238
                    tvn_player.x=6
                    tvn_player.y=33
                    tvn_player.width= 370
                    tvn_player.height= 332


}else{
                    indicator3.x=143
                    indicator3.y=151
                    indicator3.width=150
                    indicator3.height=150

                    tvn_player.anchors.verticalCenterOffset=-36
                    tvn_player.anchors.horizontalCenterOffset=-238
                    tvn_player.x=36
                    tvn_player.y=46
                    tvn_player.width= 306
                    tvn_player.height= 245

}

                pozycja_video_panel.opacity=1
                pozycja_video_panel.visible=false

                tvn_player.z=0
                telewizor.visible=true
                tvn_player.play()

            }

        }
    }

    focus: true

}

Rectangle {
    id: tlo_player
    color: "#000000"
    z: 1
    visible: false
    anchors.fill: parent
}


Timer {
    id: time
    interval: 50; running: false; repeat: false
    onTriggered: {
        //      text1.text="Powrot"
        //    lista_powrot()


        listview1.y=150

    }
}

}
