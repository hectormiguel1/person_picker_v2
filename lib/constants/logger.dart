import 'package:logger/logger.dart';

Logger logger = Logger(
    printer:
        PrettyPrinter(errorMethodCount: 1, lineLength: 100, printTime: true));
