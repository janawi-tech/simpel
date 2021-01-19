@extends('admin-template')
@section('content')

                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Kuitansi</li>
                                </ol>
                            </div>
                            <h4 class="page-title">&nbsp;</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <div class="card m-b-30">
                            <div class="card-header">
                                <button type="button" class="btn btn-gradient waves-light waves-effect w-md" id="btn-add">Tambah Data</button>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tablekuitansi">
                                  <thead>
                                    <tr>
                                      <th>No</th>
                                      <th>No Bukti</th>
                                      <th>No Order</th>
                                      <th>Tgl Pembayaran</th>
                                      <th>Pelanggan</th>
                                      <th>Dari</th>
                                      <th>Total</th>
                                      <th>Action</th>
                                    </tr>
                                  </thead>
                                  <tfoot>
                                    <tr>
                                      <th>No</th>
                                      <th>No Bukti</th>
                                      <th>No Order</th>
                                      <th>Tgl Pembayaran</th>
                                      <th>Pelanggan</th>
                                      <th>Dari</th>
                                      <th>Total</th>
                                      <th>Action</th>
                                    </tr>
                                  </tfoot>
                                </table>

                                <!-- Modal -->
                                  <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-simple" style="max-width: 750px">
                                      <form class="form-horizontal" id="frmkuitansi" autocomplete="off">
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <button type="button" class="close tutup" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                          </button>
                                          <h4 class="modal-title">Tambah Kuitansi</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">No Bukti</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control" name="no_bukti" id="no_bukti" autocomplete="off"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">No Order</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control no_order" onchange="get_customer(this.value)" name="no_order" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Customer</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control" name="customer" id="customer" readonly="readonly" />
                                                <input type="hidden" class="form-control" name="customer_id" id="customer_id"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Tgl Pembayaran</label>
                                              <div class="col-md-8">
                                                <input type="date" class="form-control" name="tgl_bayar" id="tgl_bayar"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Yang Menyerahkan Uang</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control" name="dari" id="dari" autocomplete="off"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Keterangan</label>
                                              <div class="col-md-8">
                                                <textarea class="form-control input-sm" name="keterangan" placeholder="Keterangan Pembayaran" id="keterangan" rows="4"></textarea>
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
                  </div>
                </div>

{!! HTML::script('js/ajax-kuitansi.js') !!}
@stop
