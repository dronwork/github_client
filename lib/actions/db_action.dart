class DbOnInitActions {}

class DbOnLoadAction {}

class DbOnAddAction<Model> {
  final Model model;

  DbOnAddAction(this.model);
}

class DbOnRemoveAction<Model> {
  final Model model;

  DbOnRemoveAction(this.model);
}

class DbLoadedActions<Model> {
  final List<Model> model;

  DbLoadedActions(this.model);
}
