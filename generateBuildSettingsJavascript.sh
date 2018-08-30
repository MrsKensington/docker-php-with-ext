cat << EOF
# 1. Search client.whatever.js (when pretty printed) for '"/autobuild/tags/" +'
# 2. Put a break point at the put request line
# 3. Click Save Changes
# 4. Go up the stack 4 times (function currently called L)
# 5. Put a break point on the first line of that function
# 6. Remove the other break point
# 7. Resume script execution
# 8. Click Save Changes Again
# 9. Paste the code below in
var values = "$(./buildSettingsList.sh | xargs echo)".split(" ");

var diff = values.length - (a.length * 3);
if(diff != 0) {
    throw new Error("Need " + (diff/3) + " more tags");
}

var index = 0;
for(var i=0; i<a.length; i++) {
    a[i].source_name = values[index++];
    a[i].dockerfile_location = values[index++];
    a[i].name = values[index++];
}
EOF
