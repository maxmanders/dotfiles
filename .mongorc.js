__config = {
  verbose_shell:  true,
  pretty_shell: true,
}

// Include hostname, role etc. in prompt
prompt = function() {
    var serverstatus = db.serverStatus();
    var host = serverstatus.host.split('.')[0];
    var envDomain = db.serverStatus().host.split('.').slice(-2, -1)[0];
    var envString = '';
    if (!host.startsWith('ip-')) {
        if (envDomain.toLowerCase().includes('staging')) {
            envString = '@staging';
        } else {
            envString = '@production';
        }
    }
    var repl_set = db._adminCommand({"replSetGetStatus": 1}).ok !== 0;
    var rs_state = '';
    if(repl_set) {
        var status = rs.status();
        var members = status.members;
        var rs_name = status.set;
        for(var i = 0; i < members.length; i++){
            if(members[i].self === true){
                rs_state = '[' + members[i].stateStr + ':' + rs_name + ']';
            }
        };
    }
    return host + envString + ' ' + rs_state + ' (' + db + ') ❯ ';
};

// prints the duration of each operation
setVerboseShell(__config['verbose_shell']);

// pretty print output
DBQuery.prototype._prettyShell = __config['pretty_shell'];
