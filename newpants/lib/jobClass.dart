class Job {
   String jobClass;
   String companyName;
   String jobDescription;

  Job({
    required this.jobClass,
    required this.companyName,
    required this.jobDescription,
  });

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobClass: map['jobClass'],
      companyName: map['companyName'],
      jobDescription: map['jobDescription'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobClass': jobClass,
      'companyName': companyName,
      'jobDescription': jobDescription,
    };
  }
}
