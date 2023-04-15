import 'dart:async';

import 'package:Maven/feature/program/dao/tracked_template_dao.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dao/folder_dao.dart';
import '../../dao/program_dao.dart';
import '../../model/folder.dart';
import '../../model/program.dart';
import '../../model/tracked_template.dart';

part 'program_detail_event.dart';
part 'program_detail_state.dart';

class ProgramDetailBloc extends Bloc<ProgramDetailEvent, ProgramDetailState> {
  ProgramDetailBloc({
    required this.programDao,
    required this.folderDao,
    required this.trackedTemplateDao,
  }) : super(const ProgramDetailState()) {
    on<ProgramDetailInitialize>(_initialize);
    on<ProgramDetailLoad>(_load);
  }

  final ProgramDao programDao;
  final FolderDao folderDao;
  final TrackedTemplateDao trackedTemplateDao;

  Future<void> _initialize(ProgramDetailInitialize event, Emitter<ProgramDetailState> emit) async {
    emit(state.copyWith(status: () => ProgramDetailStatus.loading,));

    emit(state.copyWith(status: () => ProgramDetailStatus.loaded,));
  }

  Future<void> _load(ProgramDetailLoad event, Emitter<ProgramDetailState> emit) async {
    emit(state.copyWith(status: () => ProgramDetailStatus.loading,));

    Program? program = await programDao.getProgram(event.programId);

    if(program == null) {
      emit(state.copyWith(status: () => ProgramDetailStatus.error,));
      return;
    }

    List<Folder> folders = await folderDao.getFoldersByProgramId(program.programId!);

    for(int i = 0; i < folders.length; i++) {
      List<TrackedTemplate> trackedTemplates = await trackedTemplateDao.getTrackedTemplatesByFolderId(folders[i].folderId!);
      folders[i] = folders[i].copyWith(trackedTemplates: trackedTemplates);
    }

    emit(state.copyWith(
      status: () => ProgramDetailStatus.loaded,
      program: () => program,
      folders: () => folders,
    ));
  }
}
