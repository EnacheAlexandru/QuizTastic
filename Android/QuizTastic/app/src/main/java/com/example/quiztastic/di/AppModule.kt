package com.example.quiztastic.di

import android.app.Application
import androidx.room.Room
import com.example.quiztastic.feature_question.data.data_source.QuestionDatabase
import com.example.quiztastic.feature_question.data.repo.QuestionRepositoryFakeImpl
import com.example.quiztastic.feature_question.data.repo.QuestionRepositoryImpl
import com.example.quiztastic.feature_question.domain.repo.QuestionRepository
import com.example.quiztastic.feature_question.domain.use_case.*
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideQuestionDatabase(app: Application): QuestionDatabase {
        return Room.databaseBuilder(
            app,
            QuestionDatabase::class.java,
            QuestionDatabase.DATABASE_NAME
        ).build()
    }

    @Provides
    @Singleton
    fun provideQuestionRepository(db: QuestionDatabase): QuestionRepository {
        return QuestionRepositoryImpl(db.questionDao)
    }

//    @Provides
//    @Singleton
//    fun provideQuestionRepository(): QuestionRepository {
//        return QuestionRepositoryFakeImpl()
//    }

    @Provides
    @Singleton
    fun provideQuestionUseCases(repo: QuestionRepository): QuestionUseCases {
        return QuestionUseCases(
            getQuestionsUseCase = GetQuestionsUseCase(repo),
            deleteQuestionUseCase = DeleteQuestionUseCase(repo),
            addQuestionUseCase = AddQuestionUseCase(repo),
            getQuestionUseCase = GetQuestionUseCase(repo)
        )
    }
}