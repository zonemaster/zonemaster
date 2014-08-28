function map(doc) {
    if (doc.request && !doc.results) {
        emit(doc.name, null);
    }
}