extension SirenWrapper {
    public subscript(trackPath: NSString) -> NSString {
        get { return processTrack(trackPath as String) as NSString }
    }
}
