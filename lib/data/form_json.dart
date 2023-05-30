import 'package:flutter/material.dart';

List<dynamic> formJSON = [
  {
    "id": "topic-explainer",
    "icon": Icons.topic,
    "color": 0xFFE0B447,
    "title": "Topic Explainer",
    "disc": "Explain Like 5 Year Old Child",
    "prompt":
        "Please explain the {topic} to me in a way that is easy to understand for someone who is {year} years old and has a basic understanding of {knows} and struggling with {struggles}. Please provide the response in markdown format, with an overview of the topic, its relevance, and any key concepts that are important to understand. Please keep the tone of the response informative and engaging.",
    "schema": {
      "properties": {
        "{topic}": {
          "type": "text",
          "title": "Topic",
          "default": "AI",
          "placeholder": "Enter Topic you want to learn"
        },
        "{year}": {
          "type": "number",
          "title": "Age",
          "default": 5,
          "placeholder": "Enter age"
        },
        "{knows}": {
          "type": "text",
          "title": "Expertise Area",
          "default": "Computer",
          "placeholder": "'computer', 'marketing', etc..."
        },
        "{struggles}": {
          "type": "text",
          "title": "you struggle with?",
          "default": "Math",
          "placeholder": "'math', 'science', etc.."
        }
      }
    }
  },
  {
    "id": "grammar-correction",
    "icon": Icons.abc,
    "color": 0xFFC36B74,
    "title": "Grammarian",
    "disc": "Check Your Grammar",
    "prompt":
        "Improve language, correct grammar and punctuation of the text delimited in backticks ```{text}```.",
    "schema": {
      "properties": {
        "{text}": {
          "type": "text",
          "title": "Enter Text",
          "default": "I is very happy",
          "placeholder": "Enter text"
        }
      }
    }
  },
  {
    "id": "code-generator",
    "icon": Icons.code,
    "color": 0xFFA4B8C4,
    "title": "Code Generator",
    "disc": "Generate Code on Your Demand",
    "prompt":
        "Generate modular and reusable code using {language} language that is optimized for performance and efficiency and adheres to coding standards and best practices. Please also include explicit instructions on any specific requirements for input variables or expected output. As needed, please engage subject matter experts with the necessary skills to successfully complete the task.",
    "schema": {
      "properties": {
        "{topic}": {
          "type": "text",
          "title": "Topic",
          "default": "Generate Fibonacci Series",
          "placeholder": "Enter Topic to generate code"
        },
        "{language}": {
          "type": "text",
          "title": "Language",
          "default": "Flutter",
          "placeholder": "Enter language"
        }
      }
    }
  },
  {
    "id": "code-debugging",
    "icon": Icons.bug_report,
    "color": 0xFF5BBA6F,
    "title": "Debug & Fix Errors in Code",
    "disc": "Helps Fix Your Code",
    "prompt": "```{code}``` Debug the following code, wrapped in backticks, and find possible errors. Fix the code, add comments where you edited it, and suggest improvements if necessary. If the code is not optimized, optimize it."
        "As you debug and improve the code, keep in mind the following"
        "- Use clear and concise variable names."
        "- Avoid using reserved keywords as function or variable names."
        "- Include comments that explain what each line of code does and your reasoning for any changes you make."
        "- Optimize the code by reducing its time complexity or memory usage, if possible. In addition, keep in mind the expertise of our three expert roles: software developer, data scientist, and cyber security expert. Try to incorporate their knowledge and skills while debugging and optimizing the code.",
    "schema": {
      "properties": {
        "{code}": {
          "type": "text",
          "title": "Enter Your Code",
          "default": "print('Hello world!)",
          "placeholder": "Enter Your Code to Fix Error"
        }
      }
    }
  },
  {
    "id": "comprehensive-study-plan",
    "color": 0xFF87677B,
    "icon": Icons.lightbulb,
    "title": "Create Study Plan",
    "disc": "Comprehensive Study Plan",
    "prompt":
        "Create a detailed study plan for mastering {topic} in {days} days. Please include specific tasks to be completed, recommendations for studying techniques or resources that would be helpful, suggestions for managing time effectively while studying, and ensure that the study plan is designed to help achieve the end goal. Additionally, please offer suggestions on how to stay motivated and focused during long-term studying, and provide guidance on how to evaluate progress and make adjustments to the study plan as needed.",
    "schema": {
      "properties": {
        "{topic}": {
          "type": "text",
          "title": "Topic",
          "default": "algebra",
          "placeholder": "Enter topic"
        },
        "{days}": {
          "type": "number",
          "title": "Days",
          "default": 15,
          "placeholder": "Number of Days to Complete Study"
        }
      }
    }
  },
  {
    "id": "summarise-text",
    "color": 0xFFf4a261,
    "icon": Icons.summarize,
    "title": "Summarize the Text",
    "disc": "Easy & Quick to Understand",
    "prompt":
        "Using Markdown format, summarize the text {text} in {count} words. Ensure the summary is clear, concise, and easy to understand for a general audience.",
    "schema": {
      "properties": {
        "{text}": {
          "type": "text",
          "title": "Enter Text",
          "default": "",
          "placeholder": "Enter text to summarize"
        },
        "{count}": {
          "type": "number",
          "title": "No. of words",
          "default": "200",
          "placeholder": "Enter a number"
        }
      }
    }
  },
  {
    "id": "compare-topics",
    "icon": Icons.compare,
    "color": 0xFF337EB0,
    "title": "Compare Topic",
    "disc": "Get Difference with Pros & Cons",
    "prompt":
        "Please compare {topic1} and {topic2} and write a markdown-formatted document with a minimum of {count} differences between the two, including their pros and cons. Make sure to ground your comparison in reliable sources of information and data.",
    "schema": {
      "properties": {
        "{topic1}": {
          "type": "text",
          "title": "Topic 1",
          "default": "algebra",
          "placeholder": "Enter First Topic"
        },
        "{topic2}": {
          "type": "text",
          "title": "Topic 2",
          "default": "calculas",
          "placeholder": "Enter Other Topic"
        },
        "{count}": {
          "type": "number",
          "title": "No. of difference",
          "default": "5",
          "placeholder": "Enter a number"
        }
      }
    }
  },
  {
    "id": "mcq-type-quiz",
    "icon": Icons.note_alt_rounded,
    "color": 0xFF61c9a8,
    "title": "MCQ Type Quiz",
    "disc": "Generate MCQs with Answer",
    "prompt":
        "Create a {number} multiple-choice quiz for topic {topic}. The output include the question, options, and correct answer for each question. Each question should be based on a distinct concept within the topic. Ensure that each question and option is semantically meaningful, and accurately reflects the content of the original topic. To achieve this, we will leverage the expertise of a Quiz Creator, a Domain Expert, and a Data Analyst. The Domain Expert will work with us to identify key concepts in the topic, the Data Analyst will use data analytics tools to analyze the results of the quiz and make improvements for future iterations. Format: Each question must starts with 'Question' keyword ,all option must starts with (A, B, C, D) enclosed with parentheses and correct answer must starts with 'Answer' keyword.",
    "schema": {
      "properties": {
        "{topic}": {
          "type": "text",
          "title": "Enter Name of the Topic",
          "default": "Indian history",
          "placeholder": "Write any topic"
        },
        "{number}": {
          "type": "number",
          "title": "No. of Questions",
          "default": "5",
          "Placeholder": "Enter number"
        }
      }
    }
  },
];
