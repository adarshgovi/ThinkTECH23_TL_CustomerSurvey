package com.example.customersurveytl

import android.content.Intent
import android.graphics.drawable.AnimationDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import androidx.constraintlayout.widget.ConstraintLayout

class SurveyTry2 : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_survey_try2)
        val startSurvey=findViewById<Button>(R.id.submit_button)

        startSurvey.setOnClickListener {
            val intent = Intent(this@SurveyTry2, SubmissionScreen::class.java)
            startActivity(intent)
        }

    }
}