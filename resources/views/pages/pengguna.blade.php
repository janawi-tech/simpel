@extends('admin-template')
@section('content')
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">Home</a></li>
        <li class="breadcrumb-item active">Pengguna</li>
      </ol>
      <h1 class="page-title">Data Pengguna</h1>
      <div class="page-header-actions">
        <button type="button" class="btn btn-sm btn-icon btn-primary btn-round btn-floating" data-toggle="tooltip"
          data-original-title="Add" id="btn-add">
          <i class="icon md-plus" aria-hidden="true"></i>
        </button>
      </div>
    </div>
    <!-- Page Content -->
    <div class="page-content container-fluid">
      <div class="row">
        <div class="col-xxl-12 col-lg-12">
          <!-- Example Panel With Heading -->
          <div class="panel panel-bordered">
            <div class="panel-body">
              <table class="table table-bordered table-hover dataTable table-striped w-full" id="tableuser">
                <thead>
                  <tr>
                    <th>No</th>
                    <th>Nama</th>
                    <th>NIP</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Groups</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>No</th>
                    <th>Nama</th>
                    <th>NIP</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Groups</th>
                    <th>Action</th>
                  </tr>
                </tfoot>
              </table>

              <!-- Modal -->
                  <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-simple" style="max-width: 750px">
                      <form class="form-horizontal" id="frmpengguna" autocomplete="off">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close tutup" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title">Tambah Pengguna</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group row form-material">
                              <label class="col-md-4 form-control-label">Nama</label>
                              <div class="col-md-8">
                                <input type="text" class="form-control" name="name" id="name" />
                              </div>
                            </div>
                            <div class="form-group row form-material">
                              <label class="col-md-4 form-control-label">NIP</label>
                              <div class="col-md-8">
                                <input type="text" class="form-control" name="nip" id="nip" />
                              </div>
                            </div>
                            <div class="form-group row form-material">
                              <label class="col-md-4 form-control-label">Username</label>
                              <div class="col-md-8">
                                <input type="text" class="form-control" id="email" name="email" />
                              </div>
                            </div>
                            <div class="form-group row form-material">
                              <label class="col-md-4 form-control-label">Password</label>
                              <div class="col-md-8">
                                <input type="text" class="form-control" name="password" id="password" />
                                <div class="checkbox-custom checkbox-primary">
                                  <input type="checkbox" class="cb" id="pass" name="pass">
                                  <label for="pass">Ubah Password</label>
                                </div>
                              </div>
                            </div>
                            <div class="form-group row form-material">
                              <label class="col-md-4 form-control-label">Nama</label>
                              <div class="col-md-8">
                                <input type="hidden" class="form-control groups" name="groups" id="groups" />
                              </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                          <button type="submit  " class="btn btn-primary" id="btn-save" value="add">Save</button>
                          <input type="hidden" id="id" name="id" value="0">
                        </div>
                      </div>
                      </form>
                    </div>
                  </div>
                  <!-- End Modal -->

            </div>
          </div>
          <!-- End Example Panel With Heading -->
        </div>
      </div>
{!! HTML::script('js/ajax-pengguna.js') !!}
@stop
