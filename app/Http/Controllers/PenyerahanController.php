<?php

namespace App\Http\Controllers;

use App\Penyerahan;
use App\Orderan;
use App\DetailPenerimaan;
use App\Petugas;
use App\SPK;
use App\VPenyerahan;
use App\ViewDetailOrders;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;

class PenyerahanController extends Controller
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
        return view('pages.penyerahan');
    }

    public function getPosts()
    {
        // DB::statement(DB::raw('set @rownum=0'));
        $penyerahan = VPenyerahan::select([
            'rownum',
            'id',
            'id_order',
            'no_order',
            'tgl_serah',
            'petugas_id',
            'petugas_lab',
            'petugas_yantek',
            'tahun'
        ]);
        // $penyerahan = Penyerahan::all();

        return DataTables::of($penyerahan)
                ->addColumn('action', function ($penyerahan) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" value="'.$penyerahan->id.'" class="btn btn-icon btn-success waves-effect waves-classic open-modal"><i class="fa fa-edit" aria-hidden="true"></i></button>
                              <button type="button" value="'.$penyerahan->id.'" class="btn btn-icon btn-danger waves-effect waves-classic btn-delete delete-task"><i class="fa fa-trash" aria-hidden="true"></i></button>
                              <a class="btn btn-icon btn-warning waves-effect waves-classic" href="'. route('penyerahan', ['id_order'=>$penyerahan->id_order,'petugas_id'=>$penyerahan->petugas_id]).'" target="_blank"><i class="fa fa-print" aria-hidden="true"></i></a>
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
        $data = Orderan::findOrFail($request->no_order);
        $penyerahan = Penyerahan::create([
            'id_order'       => $request->no_order,
            'tgl_serah'      => $request->tgl_serah,
            'no_order'       => $data->no_order,
            'petugas_lab'    => $request->petugas_lab,
            'petugas_yantek' => $request->petugas_yantek,
            'catatan' => $request->catatan
        ]);
        return Response::json($penyerahan);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $penyerahan = Penyerahan::select([
            'id',
            'id_order',
            'no_order',
            'tgl_serah',
            'petugas_lab',
            'petugas_yantek',
            DB::raw('get_nama(petugas_lab) as lab'),
            DB::raw('get_nama(petugas_yantek) as yantek')
        ])->where('id', '=', $id)->first();

        return Response::json([
            'id'=>$penyerahan->id,
            'id_order'=>$penyerahan->id_order,
            'no_order'=>$penyerahan->no_order,
            'petugas_lab'=>$penyerahan->petugas_lab,
            'lab'=>$penyerahan->lab,
            'petugas_yantek'=>$penyerahan->petugas_yantek,
            'yantek'=>$penyerahan->yantek,
            'tgl_serah'=>$penyerahan->tgl_serah,
            'catatan'=>$penyerahan->catatan
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
        $penyerahan = Penyerahan::find($id);
        $penyerahan->tgl_serah = $request->tgl_serah;
        $penyerahan->no_order = $request->no_order;
        $penyerahan->petugas_lab = $request->petugas_lab;
        $penyerahan->petugas_yantek = $request->petugas_yantek;
        $penyerahan->catatan = $request->catatan;
        $penyerahan->save();

        return Response::json($penyerahan);
    }

    public function updateDetail(Request $request)
    {
        $detail = DetailPenerimaan::find($request->id);
        $detail->catatan = $request->catatan;
        $detail->save();

        return Response::json($detail);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $penyerahan = Penyerahan::destroy($id);
        return Response::json($penyerahan);
    }

    public function getOrder($no_order, $petugas_lab)
    {
        $alat =  DB::table('lab_spk')
                    ->where('id_order','=',$no_order)
                    ->where('petugas_id','=',$petugas_lab)
                    ->select('alat_id')->get();
        $list='';
        foreach ($alat as $data) {
            $list=$list.$data->alat_id.',';
        }
        $alat_id=$list;
        $jum=0;
        foreach (count_chars($alat_id,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $alat_id);

        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }

        $order = DB::table('lab_detail_order')
                ->whereIn('lab_detail_order.id',$alatku)
                ->select(
                    'lab_detail_order.id as id',
                    DB::raw('get_alat(lab_detail_order.alat_id) as alat'),
                    'lab_detail_order.seri as seri',
                    'lab_detail_order.no_order as no_order',
                    'lab_detail_order.catatan as catatan'
                )
                ->orderBy(DB::raw('get_alat(lab_detail_order.alat_id)'),'ASC')
                ->get();

        return DataTables::of($order)
                ->addColumn('catatan', function ($order) {
                    return '
                        <textarea name="" id="'.$order->id.'" class="form-control catatan">'.$order->catatan.'</textarea>';
                })
                ->rawColumns(['catatan'])
                ->make(true);
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

    public function PetugasLab(Request $request)
    {
        $search = $request->q;
        $no_order = $request->n;

        $penyerahan = Penyerahan::where('id_order','=', $no_order)->get();
        $petugasku=array();
        foreach ($penyerahan as $data) {
            array_push($petugasku, $data->petugas_lab);
        }

        $petugas = SPK::select([
            'petugas_id',
            DB::raw('get_nama(petugas_id) as nama')
        ])
        ->where('id_order', '=', $no_order)
        ->whereNotIn('petugas_id',$petugasku)
        ->groupBy('petugas_id')
        ->get();

        return Response::json($petugas);
    }

    public function PetugasYantek(Request $request)
    {
        $search = $request->q;
        $petugas = Petugas::where('name','LIKE',"%$search%")
                    ->where('groups','=',3)
                    ->select('id','name')
                    ->get();
        return Response::json($petugas);
    }
}
