## StudentAI

StudentAI is an AI chat-bot app that helps students to learn more effectively. It uses OpenAI's API to provide students with personalized learning experiences.

### Features

* Personalized learning experiences
* Access to a vast knowledge base
* Ability to answer questions in a comprehensive and informative way
* User-friendly interface
* Chat bot with OpenAI's API integration
* Supports queries from multiple subjects and topics

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

####  API Key
Do not forget to add you API key in app before start using.
1. You can get API key from official [openAI account](https://beta.openai.com/account/api-keys)
2. You can get using free key Providers from github repo/discord server. [FoxGPT](https://discord.gg/DZnFebu8tP) 
3. Join above discord and send command `/key` to get your API key

### Examples

Here are some examples of how you can use StudentAI:

* Ask StudentAI questions about your homework or studies.
* Get StudentAI to generate MCQs, compare topics, create study plans etc.
* Have StudentAI help you with your research.
* Get StudentAI to provide you with summaries of complex topics.

### Contributing

Please feel free to  create a pull request for a bug, Feature requirement or any kind of improvement.

### License

StudentAI is licensed under the [GPL License v3](LICENSE).

### Contact

If you have any questions or feedback, please feel free to contact me at <avadhkachhadiya@gmail.com>.

## References

* [sandeepscet](https://github.com/sandeepscet/prompt-apps)
* [FoxGPT](https://api.hypere.app/)
