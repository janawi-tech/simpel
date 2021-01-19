<?php

namespace App\Http\Controllers;

use App\Bukti;
use App\Petugas;
use App\ViewSerahKerja;
use App\DetailPenerimaan;
use App\Orderan;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;

class BuktiController extends Controller
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
        return view('pages.bukti');
    }

    public function lokasi()
    {
        return view('pages.lokasi');
    }

    public function getPosts()
    {
        $bukti = ViewSerahKerja::select([
            'nomor',
            'pelanggan',
            'penyerah',
            'id',
            'id_order',
            'no_order',
            'tgl_serah',
            'penerima',
            'tahun'
        ]);
        // $bukti = Customer::all();

        return DataTables::of($bukti)
                ->addColumn('action', function ($bukti) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" value="'.$bukti->id.'" class="btn btn-icon btn-success waves-effect waves-classic open-modal"><i class="fa fa-edit" aria-hidden="true"></i></button>
                              <button type="button" value="'.$bukti->id.'" class="btn btn-icon btn-danger waves-effect waves-classic btn-delete delete-task"><i class="fa fa-trash" aria-hidden="true"></i></button>
                              <a class="btn btn-icon btn-warning waves-effect waves-classic" href="'. route('bukti', ['no_order'=>$bukti->id_order,'id'=>$bukti->id]).'" target="_blank"><i class="fa fa-print" aria-hidden="true"></i></a>
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

        $list_alat=json_encode($request->input('alat_id'));
        $jum=0;
        foreach (count_chars($list_alat,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $list_alat);
        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }

        // var_dump($alatku);
        $data = Orderan::findOrFail($request->no_order);
        DetailPenerimaan::where('id_order','=',$request->no_order)
                ->whereIn('id',$alatku)
                ->update(['ambil'=>1]);

         $bukti = Bukti::create([
                'id_order' => $request->no_order,
                'no_order' => $data->no_order,
                'alat_id' => json_encode($request->input('alat_id')),
                'tgl_serah' => $request->tgl_serah,
                'penyerah' => $request->penyerah,
                'penerima' => $request->penerima,
                'p1' => $request->p1,
                'p2' => $request->p2,
                'p3' => $request->p3,
                'p4' => $request->p4
            ]);
            return Response::json($bukti);
        // $bukti = Bukti::create($request->all());
        // return Response::json($bukti);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $bukti = Bukti::where('id','=',$id)
                            ->select([
                                'id',
                                'penerima',
                                'id_order',
                                'no_order',
                                'tgl_serah',
                                'penyerah as id_penyerah',
                                'p1',
                                'p2',
                                'p3',
                                'p4',
                                DB::raw('get_nama(penyerah) as penyerah'
                            )])->first();
        return Response::json([
            'id'=>$bukti->id,
            'id_order'=>$bukti->id_order,
            'no_order'=>$bukti->no_order,
            'tgl_serah'=>$bukti->tgl_serah,
            'id_penyerah'=>$bukti->id_penyerah,
            'p1'=>$bukti->p1,
            'p2'=>$bukti->p2,
            'p3'=>$bukti->p3,
            'p4'=>$bukti->p4,
            'penyerah'=>$bukti->penyerah,
            'penerima'=>$bukti->penerima
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
        $bukti = Bukti::find($id);
        $bukti->no_order = $request->no_order;
        $bukti->tgl_serah = $request->tgl_serah;
        $bukti->penyerah = $request->penyerah;
        $bukti->penerima = $request->penerima;
        $bukti->p1 = $request->p1;
        $bukti->p2 = $request->p2;
        $bukti->p3 = $request->p3;
        $bukti->p4 = $request->p4;
        $bukti->save();

        return Response::json($bukti);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $bukti = Bukti::where('id','=',$id)->first();
        $no_order=$bukti->id_order;
        $alat_id=$bukti->alat_id;

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


        DetailPenerimaan::where('id_order','=',$no_order)
                ->whereIn('id',$alatku)
                ->update(['ambil'=>0]);
                
        $bukti = Bukti::destroy($id);
        $buktikan = Bukti::destroy($id);
        return Response::json($buktikan);
    }

    public function getPenyerah(Request $request)
    {
        $search = $request->q;
        $petugas = Petugas::where('name','LIKE',"%$search%")
                    ->where('groups','=',3)
                    ->select('id','name')
                    ->get();
        return Response::json($petugas);
    }

    public function dataAlat($no_order)
    {
        $spk = DetailPenerimaan::where('id_order','=', $no_order)
               ->where('ambil','=',0)
               ->groupBy('id')
               ->get();

        $alatku=array();
        foreach ($spk as $row) {
            array_push($alatku, $row->alat_id);
        }

        // var_dump($alatku);
        $alat=DetailPenerimaan::select([
                'id',
                DB::raw('CONCAT(get_alat(alat_id)," - Seri :",seri) as text')
            ])
            ->where('id_order','=',$no_order)
            ->whereIn('alat_id',$alatku)
            ->where('ambil','=',0)
            ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
            ->get();

        return Response::json($alat);
    }
}
