import 'package:scoped_model/scoped_model.dart';

import 'user_mixin.dart';
import 'chair_mixin.dart';
import 'chair_state_mixin.dart';
import 'lang_mixin.dart';

class MainModel extends Model with UserMixin, ChairMixin, ChairStateMixin, LangMixin {
}