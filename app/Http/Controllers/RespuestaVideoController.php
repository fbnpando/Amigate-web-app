<?php

namespace App\Http\Controllers;

use App\Models\RespuestaVideo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class RespuestaVideoController extends Controller
{
    public function index($respuestaId)
    {
        $videos = RespuestaVideo::where('respuesta_id', $respuestaId)
            ->orderBy('orden')
            ->get();
        
        return response()->json($videos);
    }

    public function store(Request $request, $respuestaId)
    {
        $validator = Validator::make($request->all(), [
            'url' => 'required|url',
            'orden' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $video = RespuestaVideo::create([
            'respuesta_id' => $respuestaId,
            'url' => $request->url,
            'orden' => $request->orden ?? 0
        ]);
        
        return response()->json($video, 201);
    }

    public function destroy($respuestaId, $id)
    {
        $video = RespuestaVideo::where('respuesta_id', $respuestaId)
            ->findOrFail($id);
        $video->delete();
        
        return response()->json(['message' => 'Video eliminado correctamente'], 200);
    }
}
