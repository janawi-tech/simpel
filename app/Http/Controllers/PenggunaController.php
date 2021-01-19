<?php

namespace App\Http\Controllers;

use App\Pengguna;
use App\Groups;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use Hash;
use DB;


class PenggunaController extends Controller
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
        return view('pages.pengguna');
    }

    public function getPosts()
    {
        DB::statement(DB::raw('set @rownum=0'));
        $admin = Pengguna::select([
            DB::raw('@rownum  := @rownum  + 1 AS rownum'),
                DB::raw('substr(password,1,8) as password'),
            DB::raw('get_groups(groups) as groups'),
            'id',
            'name',
            'nip',
            'email'
        ]);
        // $admin = Customer::all();

        return DataTables::of($admin)
                ->addColumn('action', function ($admin) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" value="'.$admin->id.'" class="btn btn-icon btn-success waves-effect waves-classic open-modal"><i class="icon md-edit" aria-hidden="true"></i></button>
                              <button type="button" value="'.$admin->id.'" class="btn btn-icon btn-danger waves-effect waves-classic btn-delete delete-task"><i class="icon md-delete" aria-hidden="true"></i></button>
                            </div>
                        </div>
                    ';
                })
                ->rawColumns(['action'])
                ->make(true);
    }

    public function getGrid()
    {
        $pengguna =  DB::table('admins')
                    ->select(
                        'id',
                        'name',
                        'nip',
                        'email',
                        'groups as groups_id',
                        DB::raw('get_groups(groups) as groups'),
                        DB::raw('substr(password,1,8) as password')
                    )->get();

        // $pengguna = Pengguna::select([
        //     'id',
        //     'name',
        //     'nip',
        //     'email',
        //     'groups as groups_id',
        //     DB::raw('get_groups(groups) as groups'),
        //     DB::raw('substr(password,1,8) as Password')
        // ])->get();
        return Response::json($pengguna);
    }

    /**h
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
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pengguna = Pengguna::select([
            'id',
            'name',
            'email',
            'nip',
            // 'password',
            'groups as groups_id',
            DB::raw('substr(password,1,8) as password'),
            DB::raw('get_groups(groups) as groups')
        ])->where('id', '=', $id)->first();

        return Response::json([
            'id'=>$pengguna->id,
            'name'=>$pengguna->name,
            'email'=>$pengguna->email,
            'nip'=>$pengguna->nip,
            'password'=>$pengguna->password,
            'groups_id'=>$pengguna->groups_id,
            'groups'=>$pengguna->groups
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
    public function update(Request $request)
    {
        $pengguna = Pengguna::find($request->id);
        if ($request->pass==1) {
            // echo "ubah";
            $pengguna->name = $request->name;
            $pengguna->nip = $request->nip;
            $pengguna->email = $request->email;
            $pengguna->password = Hash::make($request->password);
            $pengguna->groups = $request->groups;
        }else{
            // echo "gak";
            $pengguna->name = $request->name;
            $pengguna->nip = $request->nip;
            $pengguna->email = $request->email;
            $pengguna->groups = $request->groups;
        }

        $pengguna->save();

        return Response::json($pengguna);
    }

    // public function updatePengguna(Request $request)
    // {

    // }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function dataPengguna(Request $request)
    {
        $search = $request->q;
        $groups = Groups::where('groups','LIKE',"%$search%")
                    ->select('id','groups')
                    ->orderBy('id', 'asc')
                    ->get();
        return Response::json($groups);
    }

    public function getGroups()
    {
        $groups = Groups::select([
            'groups',
            'id'
        ])->get();
        return Response::json($groups);
    }
}
