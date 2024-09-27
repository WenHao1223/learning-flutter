Uri uri = Uri.https(
        dio.options.baseUrl.replaceFirst('https://', ''), '', queryParam);
    print('Request URL: $uri');