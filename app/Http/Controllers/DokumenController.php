<?php

namespace App\Http\Controllers;

use App\Dokumen;
use App\VDokumen;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;
use URL;
use Storage;
use File;

class DokumenController extends Controller
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
        return view('pages.dokumen');
    }

    public function getPosts()
    {
        $dokumen = VDokumen::select([
            'id',
            'nomor',
            'id_order',
            'no_order',
            'dok1',
            'dok2',
            'tahun'
        ]);
        // $bukti = Customer::all();

        return DataTables::of($dokumen)
                ->addColumn('dok1', function ($dokumen) {
                    if ($dokumen->dok1=='' OR $dokumen->dok1==null) {
                        return '<label for="" class="label label-primary">None</label>';
                    }else{
                        return '<a class="btn btn-xs btn-info info-icon-notika waves-effect" target="_blank" href="'.URL::to('/')."/uploads/".$dokumen->dok1.'"><i class="fa fa-search"></i></a>';
                    }
                })
                ->addColumn('dok2', function ($dokumen) {
                    if ($dokumen->dok2=='' OR $dokumen->dok2==null) {
                        return '<label for="" class="label label-primary">None</label>';
                    }else{
                        return '<a class="btn btn-xs btn-info info-icon-notika waves-effect" target="_blank" href="'.URL::to('/')."/uploads/".$dokumen->dok2.'"><i class="fa fa-search"></i></a>';
                    }
                })
                ->addColumn('action', function ($dokumen) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" value="'.$dokumen->id.'" class="btn btn-icon btn-success waves-effect waves-classic btn-edit"><i class="fa fa-edit" aria-hidden="true"></i></button>
                              <button type="button" value="'.$dokumen->id.'" class="btn btn-icon btn-danger waves-effect waves-classic btn-delete delete-task"><i class="fa fa-trash" aria-hidden="true"></i></button>
                            </div>
                        </div>
                    ';
                })
                ->rawColumns(['action','dok1','dok2'])
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

        if (!is_null($request->file('dok1')) AND is_null($request->file('dok2'))) {
            $originalImage1= $request->file('dok1');

            $dokumen = Dokumen::create([
                'id_order'  => $request->no_order,
                'dok1'      => $originalImage1->hashName()
            ]);

            $originalImage1->move('uploads', $originalImage1->hashName());
        }elseif (!is_null($request->file('dok2')) AND is_null($request->file('dok1'))) {
            $originalImage2= $request->file('dok2');

            $dokumen = Dokumen::create([
                'id_order'  => $request->no_order,
                'dok2'      => $originalImage2->hashName()
            ]);

            $originalImage2->move('uploads', $originalImage2->hashName());
        }elseif (!is_null($request->file('dok2')) AND !is_null($request->file('dok1'))) {
            $originalImage1= $request->file('dok1');
            $originalImage2= $request->file('dok2');

            $dokumen = Dokumen::create([
                'id_order'  => $request->no_order,
                'dok1'      => $originalImage1->hashName(),
                'dok2'      => $originalImage2->hashName()
            ]);

            $originalImage1->move('uploads', $originalImage1->hashName());
            $originalImage2->move('uploads', $originalImage2->hashName());
        }else{
            $dokumen = Dokumen::create([
                'id_order'  => $request->no_order
            ]);
        }

            
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $dokumen = VDokumen::findOrFail($id);
        return Response::json([
            'id'=>$dokumen->id,
            'id_order'=>$dokumen->id_order,
            'no_order'=>$dokumen->no_order,
            'dok1'=>$dokumen->dok1,
            'dok2'=>$dokumen->dok2
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
        $dokumen = Dokumen::findOrFail($id);
        // var_dump(is_null($request->file('dok1')));
        // var_dump(is_null($request->file('dok2')));
        if (!is_null($request->file('dok1')) AND is_null($request->file('dok2'))) {
            echo "1";
            File::delete('uploads/'.$dokumen->dok1);
            $originalImage1= $request->file('dok1');
            $dokumen->id_order = $request->no_order;
            $dokumen->dok1 = $originalImage1->hashName();
            $dokumen->save();
            $originalImage1->move('uploads', $originalImage1->hashName());
        }elseif (!is_null($request->file('dok2')) AND is_null($request->file('dok1'))) {
            echo "2";
            File::delete('uploads/'.$dokumen->dok2);
            $originalImage2= $request->file('dok2');
            $dokumen->id_order = $request->no_order;
            $dokumen->dok2 = $originalImage2->hashName();
            $dokumen->save();
            $originalImage2->move('uploads', $originalImage2->hashName());
        }elseif (!is_null($request->file('dok2')) AND !is_null($request->file('dok1'))) {
            echo "3";
            File::delete('uploads/'.$dokumen->dok1);
            File::delete('uploads/'.$dokumen->dok2);
            $originalImage1= $request->file('dok1');
            $originalImage2= $request->file('dok2');
            $dokumen->id_order = $request->no_order;
            $dokumen->dok1 = $originalImage1->hashName();
            $dokumen->dok2 = $originalImage2->hashName();
            $dokumen->save();
            $originalImage1->move('uploads', $originalImage1->hashName());
            $originalImage2->move('uploads', $originalImage2->hashName());
        }else{
            echo "4";
            // $dokumen->id_order = $request->no_order;
            // $dokumen->save();
        }
        
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $dokumen = Dokumen::findOrFail($id);
        $data=$dokumen->delete();

        if (!is_null($dokumen->dok1)) {
            File::delete('uploads/'.$dokumen->dok1);
        }
        if (!is_null($dokumen->dok2)) {
            File::delete('uploads/'.$dokumen->dok2);
        }
        
    }
}
