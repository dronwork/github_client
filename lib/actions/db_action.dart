class DbOnInitAction {}

class DbOnLoadAction {}

class DbOnAddAction<Model> {
  final Model model;

  DbOnAddAction(this.model);
}

class DbOnRemoveAction<Model> {
  final Model model;

  DbOnRemoveAction(this.model);
}

class DbLoadedAction<Model> {
  final List<Model> model;

  DbLoadedAction(this.model);
}
