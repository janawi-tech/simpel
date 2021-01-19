<?php

namespace App\Http\Controllers;

use App\Kuitansi;
use App\Orderan;
use App\Customer;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;

class KuitansiController extends Controller
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
        return view('pages.kuitansi');
    }

    public function getPosts()
    {
        DB::statement(DB::raw('set @rownum=0'));
        $kuitansi = Kuitansi::select([
            DB::raw('@rownum  := @rownum  + 1 AS rownum'),
            DB::raw('concat("Rp ", format( get_total(no_order), 0)) as total'),
            DB::raw('get_customer(no_order) as customer'),
            'id',
            'no_bukti',
            'no_order',
            'tgl_bayar',
            'dari'
        ])->orderBy('tgl_bayar','desc');
        // $kuitansi = Customer::all();

        return DataTables::of($kuitansi)
                ->addColumn('action', function ($kuitansi) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" value="'.$kuitansi->id.'" class="btn btn-icon btn-success waves-effect waves-classic open-modal"><i class="fa fa-edit" aria-hidden="true"></i></button>
                              <button type="button" value="'.$kuitansi->id.'" class="btn btn-icon btn-danger waves-effect waves-classic btn-delete delete-task"><i class="fa fa-trash" aria-hidden="true"></i></button>
                              <a class="btn btn-icon btn-warning waves-effect waves-classic" href="'. route('kuitansi', ['no_bukti'=>$kuitansi->no_order]).'" target="_blank"><i class="fa fa-print" aria-hidden="true"></i></a>
                            </div>
                        </div>
                    ';
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
        $kuitansi = Kuitansi::create($request->all());
        return Response::json($kuitansi);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $kuitansi = Kuitansi::find($id)
                            ->select([
                                'id',
                                'no_bukti',
                                'no_order',
                                'tgl_bayar',
                                'customer_id',
                                DB::raw('get_customer(no_order) as customer'),
                                'dari',
                                'keterangan'])->first();
        return Response::json([
            'id'=>$kuitansi->id,
            'no_bukti'=>$kuitansi->no_bukti,
            'no_order'=>$kuitansi->no_order,
            'tgl_bayar'=>$kuitansi->tgl_bayar,
            'customer_id'=>$kuitansi->customer_id,
            'customer'=>$kuitansi->customer,
            'dari'=>$kuitansi->dari,
            'keterangan'=>$kuitansi->keterangan
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
        $kuitansi = Kuitansi::find($id);
        $kuitansi->no_bukti = $request->no_bukti;
        $kuitansi->no_order = $request->no_order;
        $kuitansi->tgl_bayar = $request->tgl_bayar;
        $kuitansi->customer_id = $request->customer_id;
        $kuitansi->dari = $request->dari;
        $kuitansi->keterangan = $request->keterangan;
        $kuitansi->save();

        return Response::json($kuitansi);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $kuitansi = Kuitansi::destroy($id);
        return Response::json($kuitansi);
    }

    public function dataOrder(Request $request)
    {
        $search = $request->q;
        $order = Orderan::where('no_order','LIKE',"%$search%")
                    ->select([
                        'id',
                        DB::raw('CONCAT(no_order," --- ",YEAR(tgl_terima)) as no_order')
                    ])
                    ->orderBy('created_at', 'desc')
                    ->take(10)
                    ->get();
        return Response::json($order);
    }

    public function getCustomer($no_order){
        $customer = Customer::where('no_order','=',$no_order)
                    ->select('id','pemilik')
                    ->first();
        return Response::json([
            'id'=>$customer->id,
            'pemilik'=>$customer->pemilik
        ]);
    }
}
