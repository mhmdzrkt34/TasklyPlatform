class NoteModel {

  late String id;

  late String note;
  late String title;
  late String user_id;

  late bool isLoading=false;




  NoteModel({required this.id,required this.note,required this.title,required this.user_id});





  static NoteModel fromJson(Map<String,dynamic> jsonData){

    return  NoteModel(id: jsonData['id'], note: jsonData['note'], title: jsonData['title'], user_id: jsonData['user_id']);
  }


  Map<String,dynamic> toJson(){


    return {

      "id":this.id,
      "title":this.title,
      "note":this.note,
      "user_id":this.user_id
    };
  }







}