<?php

namespace App\Http\Controllers;

use App\Provinsi;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;


class ProvinsiController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pages.provinsi');
    }

    public function getPosts()
    {
        DB::statement(DB::raw('set @rownum=0'));
        $provinsi = Provinsi::select([
            DB::raw('@rownum  := @rownum  + 1 AS rownum'),
            'id',
            'name',
            'propinsi_id']);
        // $provinsi = Customer::all();

        return DataTables::of($provinsi)
                ->addColumn('action', function ($provinsi) {
                    return '
                            <button type="button" class="btn btn-sm btn-icon btn-success waves-effect waves-classic open-modal" value="'.$provinsi->id.'"><i class="icon md-edit" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btn btn-sm btn-icon btn-danger waves-effect waves-classic btn-delete delete-task" value="'.$provinsi->id.'"><i class="icon md-delete" aria-hidden="true"></i>
                            </button>';
                })
                ->rawColumns(['action'])
                ->make(true);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $provinsi = Provinsi::create($request->all());
        return Response::json($provinsi);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $provinsi = Provinsi::find($id);
        return Response::json([
            'id'=>$provinsi->id,
            'name'=>$provinsi->name,
            'propinsi_id'=>$provinsi->propinsi_id
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $provinsi = Provinsi::find($id);
        $provinsi->name = $request->name;
        $provinsi->propinsi_id = $request->propinsi_id;
        $provinsi->save();

        return Response::json($provinsi);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $provinsi = Provinsi::destroy($id);
        return Response::json($provinsi);
    }
}
