import 'dart:collection';
import 'dart:developer';
import 'dart:ffi';

import 'package:colusseum/features/db_helper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{
static var  db , matchCollection , userCollection;
static connect()
async {
  db = await Db.create(MONGO_CONN_URL);
  await db.open();
  inspect(db);
  // if (kDebugMode) {
  // print("connected");
  // }
  matchCollection = db.collection(MATCH_COLLECTION);
  userCollection  = db.collection(USER_COLLECTION);
}

static insertUser(String email, int level, int exp, int coins)
async {
  print("Inserted into database");

   await userCollection.insertMany([
    {
      'Email': email,
      'Level': level,
      'Exp': exp,
      'Coins': coins
    },
  ]);
}


static insertQuestion(String code, List<String> questions, List<String> optionA, List<String> optionB, List<String> optionC, List<String> optionD, List<String> correctAnswer)
async {
  print("Inserted into database");

   await matchCollection.insertMany([
    {
      'Code' : code,
      'Questions' : questions,
      'OptionA' : optionA,
      'OptionB' : optionB,
      'OptionC' : optionC,
      'OptionD' : optionD,
      'Correct' : correctAnswer,
      'Submissions' : 0,
      'Players' : [],
      'Scores' : []
    },
  ]);
}

static  Future<List<Map<String, dynamic>>> findMatch(String code)
async {
   var cursor = await matchCollection.find({"Code" : code});
   return await cursor.toList();
}

static  Future<List<Map<String, dynamic>>> findUser(String email)
async {
   var cursor = await userCollection.find({"Email" : email});
   return await cursor.toList();
}


static  void addPlayerScore(int score)
async {
   
  var filter = where.eq('Code', currentMatch);

  var update = modify.push('Players', currentUserDart);

  var filter2 = where.eq('Code', currentMatch);

  var update2 = modify.push('Scores', score);

  await matchCollection.update(filter, update);
  await matchCollection.update(filter2, update2);
   
}

static  void submit()
async {
   
  var filter = where.eq('Code', currentMatch);

  var update = modify.inc('Submissions', 1);

  await matchCollection.update(filter, update);
   
}

static  void purchaseBolt()
async {
   
  var filter = where.eq('Email', currentUserDart);
  
  var update = modify.inc('Bolts', 1);

  var arr = await findUser(currentUserDart);
  for(var doc in arr)
  {
    currentUserBolts = doc["Bolts"];
  }
  await userCollection.update(filter, update);
   
}

static  void deductBolt()
async {
   
  var filter = where.eq('Email', currentUserDart);
  
  var update = modify.inc('Bolts', -1);

  var arr = await findUser(currentUserDart);
  for(var doc in arr)
  {
    currentUserBolts = doc["Bolts"];
  }
  
  await userCollection.update(filter, update);
   
}

static  void deductCash(int cost)
async {
   
  var filter = where.eq('Email', currentUserDart);

  var update = modify.inc('Coins', -cost);

  await userCollection.update(filter, update);

  var arr = await findUser(currentUserDart);
  for(var doc in arr)
  {
    currentUserCoins = doc["Coins"];
  }

  // print(currentUserCoins);
   
}

static  void win1()
async {
   
  var filter = where.eq('Email', currentUserDart);

  var update = modify.inc('Exp', 50);

  await userCollection.update(filter, update);
   
}

static  void win2()
async {
   
  var filter = where.eq('Email', currentUserDart);

  var update = modify.inc('Coins', 30);

  await userCollection.update(filter, update);
   
}

static  void win3(int lvl)
async {
   
  var filter = where.eq('Email', currentUserDart);

  var update = modify.max('Level', lvl);

  await userCollection.update(filter, update);
   
}

}