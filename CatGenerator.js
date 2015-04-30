var sprite;
var component;
var URL_1 = "http://animalia-life.com/data_images/cat/cat7.jpg";
var URL_2 = "http://upload.wikimedia.org/wikipedia/commons/2/22/Turkish_Van_Cat.jpg";
var final = "http://animalia-life.com/data_images/cat/cat7.jpg";
var check = true;

function fetchCatBackground() {
    component = Qt.createQmlObject(
        'import QtQuick 2.0; Image { anchors.fill: parent; fillMode: Image.PreserveAspectCrop; clip: true; source: "' + final + '"  }',
        backgroundParent,
        "dynamicSnippet1"
        );

    if(check) {
        check = false;
        final = URL_2;
    } else {
        check = true;
        final = URL_1;
    }

}


