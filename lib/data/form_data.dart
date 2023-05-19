List<dynamic> formJSON = [
  {
    "id": "topic-explainer",
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
          "placeholder": "Enter your expert areas, in comma separate format"
        },
        "{struggles}": {
          "type": "text",
          "title": "you struggle with?",
          "default": "Math",
          "placeholder":
              "Enter area that you mostly struggle, in comma separate format"
        }
      }
    }
  },
  {
    "id": "compare-topics",
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
    "id": "summarise-text",
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
    "id": "mcq-type-quiz",
    "prompt":
        "Create a {number} multiple-choice quiz from text {text}. The output should be in markdown format and include the question, options, and correct answer for each question. Each question should be based on a distinct concept within the text, and four options (including the correct answer) should be provided for each question. The correct answer should be indicated with an asterisk (*) immediately following the option. Ensure that each question and option is grammatically correct, semantically meaningful, and accurately reflects the content of the original text. To achieve this, we will leverage the expertise of an Instructional Designer, a Natural Language Processing Expert, a Quiz Creator, a Markdown Specialist, a Content Editor, a Domain Expert, a UX Designer, and a Data Analyst. The Domain Expert will work with us to identify key concepts in the text, the UX Designer will design an intuitive and engaging user interface for the quiz, and the Data Analyst will use data analytics tools to analyze the results of the quiz and make improvements for future iterations.",
    "schema": {
      "properties": {
        "{text}": {
          "type": "text",
          "title": "Enter Name of the Topic",
          "default": "Indian history",
          "placeholder": "Indian history"
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
  {
    "id": "comprehensive-study-plan",
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
  }
];
