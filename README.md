## StudentAI

StudentAI is an AI chatbot app designed to enhance students' learning experiences through personalized interactions. The app uses OpenAI's API to provide students with comprehensive and informative answers to their questions.

### Features

-   Personalized learning experiences tailored to each student's needs
-   Access to a vast knowledge base covering multiple subjects and topics
-   Ability to answer questions in a comprehensive and informative way
-   User-friendly interface designed for seamless interactions
-   Chatbot with OpenAI's API integration for accurate responses

### Getting Started

To get started with StudentAI, you will need to:

1. Install the Flutter SDK.
2. Clone the StudentAI repository.
3. Create a file named `secrets.dart` in the `/lib/data` directory and copy the following code into it:

    ```dart
    //This file is intended for development purposes only. Please ensure that you add it to the .gitignore file before pushing your source code anywhere.
    const String devApiKey = 'YOUR-API-KEY';

    // wiredash secrets
    // Create account in https://wiredash.io/ to use its Feedback SDK
    const String label1 = 'LABEL-ID';
    const String label2 = 'LABEL-ID';
    const String label13 = 'LABEL-ID';
    const String projectId = 'PROJECT-ID';
    const String secretKey = 'SECRET-KEY';
    ```

    This application stores all its secrets in the `secrets.dart` file. Please ensure that you keep this file secure and out of version control systems like Git. It is also recommended that you don't hardcode secrets in your code and instead use encrypted environment variables.

4. Run `flutter pub get` to install the dependencies.
5. Run `flutter run` to start the app.

### Usage

Once the app is running, you can start chatting with StudentAI by typing in your questions or requests. StudentAI will use its knowledge base and OpenAI's API to provide you with personalized learning experiences.

#### API Key

Before starting to use the app, add your API key to the app. Here are some ways to get your API key:

<<<<<<< HEAD
1. Get your API key from the official [OpenAI account](https://beta.openai.com/account/api-keys).
=======
Get your API key from the official [OpenAI account](https://beta.openai.com/account/api-keys).
>>>>>>> alpha

### Data

All data used in this app to create cards, forms, and prompts come through our API - StudentAI
API. For more information about the API, please check the following repository: [StudentAI_API](https://github.com/Avadhkumar-geek/StudentAI_API).

### Examples

Here are some examples of how you can use StudentAI:

-   Ask StudentAI questions about your homework or studies.
-   Get StudentAI to generate MCQs, compare topics, create study plans, etc.
-   Have StudentAI help you with your research.
-   Get StudentAI to provide you with summaries of complex topics.

### Contributing

We welcome contributions from the community. Please feel free to create a pull request for bug fixes, feature requests, or any other improvements.

### License

StudentAI is licensed under the [GPL License v3](LICENSE).

### Contact

If you have any questions or feedback, please feel free to contact us at <avadhkachhadiya@gmail.com>.

## References

<<<<<<< HEAD
* [sandeepscet](https://github.com/sandeepscet/prompt-apps)
=======
-   [sandeepscet](https://github.com/sandeepscet/prompt-apps)
>>>>>>> alpha
