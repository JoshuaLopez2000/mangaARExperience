using UnityEngine;
using Vuforia;
using UnityEngine.Video;

public class VideoPlayback : MonoBehaviour
{
    private ObserverBehaviour mObserverBehaviour;
    public VideoPlayer videoPlayer;
    public string videoFileName = "your_video.mp4"; // Nombre del archivo en StreamingAssets

    void Start()
    {
        mObserverBehaviour = GetComponent<ObserverBehaviour>();
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged += OnTargetStatusChanged;
        }

        // Configura la ruta del video desde StreamingAssets
        string videoPath = System.IO.Path.Combine(Application.streamingAssetsPath, videoFileName);
        videoPlayer.url = videoPath;
    }

    private void OnDestroy()
    {
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged -= OnTargetStatusChanged;
        }
    }

    private void OnTargetStatusChanged(ObserverBehaviour behaviour, TargetStatus targetStatus)
    {
        if (targetStatus.Status == Status.TRACKED)
        {
            videoPlayer.Play(); // La imagen ha sido reconocida, comienza a reproducir el video
        }
        else if (targetStatus.Status != Status.TRACKED)
        {
            videoPlayer.Stop(); // La imagen ha sido perdida, detén el video
        }
    }
}
