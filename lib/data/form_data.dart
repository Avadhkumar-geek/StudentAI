List<dynamic> formDataMain = [
  {
    "id": "topic-explainer",
    "prompt":
        "Explain the {topic} to me, i am {year} year old and knows about {knows} and struggles with the {struggles}, provide response in markdown",
    "schema": {
      "properties": {
        "{topic}": {
          "type": 'text',
          "title": "Topic",
          "default": "AI",
          "placeholder": "Enter Topic you want to learn"
        },
        "{year}": {
          "type": "number",
          "title": "Age",
          "default": 5,
          "placeholder": "Enter age",
        },
        "{knows}": {
          "type": 'text',
          "title": "Expertise Area",
          "default": "Computer",
          "placeholder": "Enter your expert areas, in comma separate format"
        },
        "{struggles}": {
          "type": 'text',
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
        "Compare {topic1} and {topic2} and give me atleast {count} diffrences with pros and cons in markdown table format",
    "schema": {
      "properties": {
        "{topic1}": {
          "type": 'text',
          "title": "Topic 1",
          "default": "algebra",
          "placeholder": "Enter First Topic"
        },
        "{topic2}": {
          "type": 'text',
          "title": "Topic 2",
          "default": "calculas",
          "placeholder": "Enter Other Topic"
        },
        "{count}": {
          "type": 'number',
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
        "Summarise the text delimited with triple backticks ```{text}``` and output format summary: in {count} words",
    "schema": {
      "properties": {
        "{text}": {
          "type": 'text',
          "title": "Enter Text",
          "default": "",
          "placeholder": "Enter text to summarize",
        },
        "{count}": {
          "type": 'number',
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
        "Create MCQ type quiz  from text delimited with triple backticks ```{text}```. output should be in markdown with format : Question , options and correct answer",
    "schema": {
      "properties": {
        "{text}": {
          "type": 'text',
          "title": "Enter Text",
          "default": "Text",
          "placeholder": "Enter question",
        }
      }
    }
  },
  {
    "id": "comprehensive-study-plan",
    "prompt": "Create study plan for a goal to {topic} in {days} Days",
    "schema": {
      "properties": {
        "{topic}": {
          "type": 'text',
          "title": "Topic",
          "default": "algebra",
          "placeholder": "Enter topic",
        },
        "{days}": {
          "type": "number",
          "title": "Days",
          "default": 15,
          "placeholder": "Number of Days to Complete Study",
        }
      }
    }
  },
];
