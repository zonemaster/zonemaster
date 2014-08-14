function(doc){
    if (doc.results[0]["start_time"] && !doc.results[0]["end_time"]) {
        var r = doc.results[0];
        emit([r.nodename, r.scanner_pid, doc.name], 1);
    }
}