cat << EOF
function f() {
    var values = "$(./buildSettingsList.sh | xargs echo)".split(" ");
    var inputs = document.getElementsByClassName("SimpleInput__default___gdtxe");
    if(inputs.length - 1 != values.length) {
        var num = (values.length - inputs.length + 1) / 3;
        alert("Need another " + num + " config lines");
        return;
    }

    for(var i=0; i<values.length; i++) {
        inputs.item(i).value = values[i];
    }
}
f();
EOF
