// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Question extends DataClass implements Insertable<Question> {
  final int id;
  final String questionText;
  final String correctAnswer;
  final String wrongAnswerOne;
  final String wrongAnswerTwo;
  final String wrongAnswerThree;
  final String category;
  Question(
      {required this.id,
      required this.questionText,
      required this.correctAnswer,
      required this.wrongAnswerOne,
      required this.wrongAnswerTwo,
      required this.wrongAnswerThree,
      required this.category});
  factory Question.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Question(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      questionText: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}question_text'])!,
      correctAnswer: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}correct_answer'])!,
      wrongAnswerOne: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}wrong_answer_one'])!,
      wrongAnswerTwo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}wrong_answer_two'])!,
      wrongAnswerThree: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}wrong_answer_three'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_text'] = Variable<String>(questionText);
    map['correct_answer'] = Variable<String>(correctAnswer);
    map['wrong_answer_one'] = Variable<String>(wrongAnswerOne);
    map['wrong_answer_two'] = Variable<String>(wrongAnswerTwo);
    map['wrong_answer_three'] = Variable<String>(wrongAnswerThree);
    map['category'] = Variable<String>(category);
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      questionText: Value(questionText),
      correctAnswer: Value(correctAnswer),
      wrongAnswerOne: Value(wrongAnswerOne),
      wrongAnswerTwo: Value(wrongAnswerTwo),
      wrongAnswerThree: Value(wrongAnswerThree),
      category: Value(category),
    );
  }

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<int>(json['id']),
      questionText: serializer.fromJson<String>(json['questionText']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      wrongAnswerOne: serializer.fromJson<String>(json['wrongAnswerOne']),
      wrongAnswerTwo: serializer.fromJson<String>(json['wrongAnswerTwo']),
      wrongAnswerThree: serializer.fromJson<String>(json['wrongAnswerThree']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionText': serializer.toJson<String>(questionText),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'wrongAnswerOne': serializer.toJson<String>(wrongAnswerOne),
      'wrongAnswerTwo': serializer.toJson<String>(wrongAnswerTwo),
      'wrongAnswerThree': serializer.toJson<String>(wrongAnswerThree),
      'category': serializer.toJson<String>(category),
    };
  }

  Question copyWith(
          {int? id,
          String? questionText,
          String? correctAnswer,
          String? wrongAnswerOne,
          String? wrongAnswerTwo,
          String? wrongAnswerThree,
          String? category}) =>
      Question(
        id: id ?? this.id,
        questionText: questionText ?? this.questionText,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        wrongAnswerOne: wrongAnswerOne ?? this.wrongAnswerOne,
        wrongAnswerTwo: wrongAnswerTwo ?? this.wrongAnswerTwo,
        wrongAnswerThree: wrongAnswerThree ?? this.wrongAnswerThree,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('questionText: $questionText, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('wrongAnswerOne: $wrongAnswerOne, ')
          ..write('wrongAnswerTwo: $wrongAnswerTwo, ')
          ..write('wrongAnswerThree: $wrongAnswerThree, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionText, correctAnswer,
      wrongAnswerOne, wrongAnswerTwo, wrongAnswerThree, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.questionText == this.questionText &&
          other.correctAnswer == this.correctAnswer &&
          other.wrongAnswerOne == this.wrongAnswerOne &&
          other.wrongAnswerTwo == this.wrongAnswerTwo &&
          other.wrongAnswerThree == this.wrongAnswerThree &&
          other.category == this.category);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<int> id;
  final Value<String> questionText;
  final Value<String> correctAnswer;
  final Value<String> wrongAnswerOne;
  final Value<String> wrongAnswerTwo;
  final Value<String> wrongAnswerThree;
  final Value<String> category;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.questionText = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.wrongAnswerOne = const Value.absent(),
    this.wrongAnswerTwo = const Value.absent(),
    this.wrongAnswerThree = const Value.absent(),
    this.category = const Value.absent(),
  });
  QuestionsCompanion.insert({
    this.id = const Value.absent(),
    required String questionText,
    required String correctAnswer,
    required String wrongAnswerOne,
    required String wrongAnswerTwo,
    required String wrongAnswerThree,
    required String category,
  })  : questionText = Value(questionText),
        correctAnswer = Value(correctAnswer),
        wrongAnswerOne = Value(wrongAnswerOne),
        wrongAnswerTwo = Value(wrongAnswerTwo),
        wrongAnswerThree = Value(wrongAnswerThree),
        category = Value(category);
  static Insertable<Question> custom({
    Expression<int>? id,
    Expression<String>? questionText,
    Expression<String>? correctAnswer,
    Expression<String>? wrongAnswerOne,
    Expression<String>? wrongAnswerTwo,
    Expression<String>? wrongAnswerThree,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionText != null) 'question_text': questionText,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (wrongAnswerOne != null) 'wrong_answer_one': wrongAnswerOne,
      if (wrongAnswerTwo != null) 'wrong_answer_two': wrongAnswerTwo,
      if (wrongAnswerThree != null) 'wrong_answer_three': wrongAnswerThree,
      if (category != null) 'category': category,
    });
  }

  QuestionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? questionText,
      Value<String>? correctAnswer,
      Value<String>? wrongAnswerOne,
      Value<String>? wrongAnswerTwo,
      Value<String>? wrongAnswerThree,
      Value<String>? category}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongAnswerOne: wrongAnswerOne ?? this.wrongAnswerOne,
      wrongAnswerTwo: wrongAnswerTwo ?? this.wrongAnswerTwo,
      wrongAnswerThree: wrongAnswerThree ?? this.wrongAnswerThree,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionText.present) {
      map['question_text'] = Variable<String>(questionText.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (wrongAnswerOne.present) {
      map['wrong_answer_one'] = Variable<String>(wrongAnswerOne.value);
    }
    if (wrongAnswerTwo.present) {
      map['wrong_answer_two'] = Variable<String>(wrongAnswerTwo.value);
    }
    if (wrongAnswerThree.present) {
      map['wrong_answer_three'] = Variable<String>(wrongAnswerThree.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('questionText: $questionText, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('wrongAnswerOne: $wrongAnswerOne, ')
          ..write('wrongAnswerTwo: $wrongAnswerTwo, ')
          ..write('wrongAnswerThree: $wrongAnswerThree, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  final GeneratedDatabase _db;
  final String? _alias;
  $QuestionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _questionTextMeta =
      const VerificationMeta('questionText');
  late final GeneratedColumn<String?> questionText = GeneratedColumn<String?>(
      'question_text', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  late final GeneratedColumn<String?> correctAnswer = GeneratedColumn<String?>(
      'correct_answer', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _wrongAnswerOneMeta =
      const VerificationMeta('wrongAnswerOne');
  late final GeneratedColumn<String?> wrongAnswerOne = GeneratedColumn<String?>(
      'wrong_answer_one', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _wrongAnswerTwoMeta =
      const VerificationMeta('wrongAnswerTwo');
  late final GeneratedColumn<String?> wrongAnswerTwo = GeneratedColumn<String?>(
      'wrong_answer_two', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _wrongAnswerThreeMeta =
      const VerificationMeta('wrongAnswerThree');
  late final GeneratedColumn<String?> wrongAnswerThree =
      GeneratedColumn<String?>('wrong_answer_three', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 100),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionText,
        correctAnswer,
        wrongAnswerOne,
        wrongAnswerTwo,
        wrongAnswerThree,
        category
      ];
  @override
  String get aliasedName => _alias ?? 'questions';
  @override
  String get actualTableName => 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<Question> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_text')) {
      context.handle(
          _questionTextMeta,
          questionText.isAcceptableOrUnknown(
              data['question_text']!, _questionTextMeta));
    } else if (isInserting) {
      context.missing(_questionTextMeta);
    }
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    } else if (isInserting) {
      context.missing(_correctAnswerMeta);
    }
    if (data.containsKey('wrong_answer_one')) {
      context.handle(
          _wrongAnswerOneMeta,
          wrongAnswerOne.isAcceptableOrUnknown(
              data['wrong_answer_one']!, _wrongAnswerOneMeta));
    } else if (isInserting) {
      context.missing(_wrongAnswerOneMeta);
    }
    if (data.containsKey('wrong_answer_two')) {
      context.handle(
          _wrongAnswerTwoMeta,
          wrongAnswerTwo.isAcceptableOrUnknown(
              data['wrong_answer_two']!, _wrongAnswerTwoMeta));
    } else if (isInserting) {
      context.missing(_wrongAnswerTwoMeta);
    }
    if (data.containsKey('wrong_answer_three')) {
      context.handle(
          _wrongAnswerThreeMeta,
          wrongAnswerThree.isAcceptableOrUnknown(
              data['wrong_answer_three']!, _wrongAnswerThreeMeta));
    } else if (isInserting) {
      context.missing(_wrongAnswerThreeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Question.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $QuestionsTable questions = $QuestionsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [questions];
}
