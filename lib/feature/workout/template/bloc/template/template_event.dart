part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object> get props => [];
}

class TemplateInitialize extends TemplateEvent {}

class TemplateAdd extends TemplateEvent {
  final Template template;
  final List<ExerciseBlockData> exerciseBlocks;

  const TemplateAdd({
    required this.template,
    required this.exerciseBlocks
  });

  @override
  List<Object> get props => [template, exerciseBlocks];
}

class TemplateReorder extends TemplateEvent {
  final List<Template> templates;

  const TemplateReorder({
    required this.templates
  });

  @override
  List<Object> get props => [templates];
}

class TemplateDelete extends TemplateEvent {
  final int templateId;

  const TemplateDelete(this.templateId);

  @override
  List<Object> get props => [templateId];
}




class TemplateFolderAdd extends TemplateEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderAdd({
    required this.templateFolder,
  });

  @override
  List<Object> get props => [templateFolder];
}

class TemplateFolderUpdate extends TemplateEvent {
  final TemplateFolder templateFolder;

  const TemplateFolderUpdate({
    required this.templateFolder
  });

  @override
  List<Object> get props => [templateFolder];
}

class TemplateFolderReorder extends TemplateEvent {
  final List<TemplateFolder> templateFolders;

  const TemplateFolderReorder({
    required this.templateFolders,
  });

  @override
  List<Object> get props => [templateFolders];
}

class TemplateMoveToFolder extends TemplateEvent {


  @override
  List<Object> get props => [];
}