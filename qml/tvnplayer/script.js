var myArray = new Array()
var myArray2 = new Array()
var m = new Array()

 function getList() {
     return myArray
 }

function getList2() {
    return myArray2
}

function getlastm() {
    return m
}

function reset() {
    myArray=Array()
    myArray2=Array()
    m=Array()
    return true
}
 function addItem(item,item2,item3) {
     myArray.push(item)
     myArray2.push(item2)
    m.push(item3)
 }
