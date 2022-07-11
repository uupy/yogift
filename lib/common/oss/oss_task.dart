class OssTask {
  String? filePath;
  String? fileName;
  String? uploadPath;
  String? type;
  String? cancelTokenKey;

  OssTask({
    this.filePath,
    this.fileName,
    this.uploadPath,
    this.type,
    this.cancelTokenKey,
  });

  OssTask.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    fileName = json['fileName'];
    uploadPath = json['ossPath'];
    type = json['type'];
    cancelTokenKey = json['cancelTokenKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filePath'] = filePath;
    data['fileName'] = fileName;
    data['ossPath'] = uploadPath;
    data['type'] = type;
    data['cancelTokenKey'] = cancelTokenKey;
    return data;
  }
}
