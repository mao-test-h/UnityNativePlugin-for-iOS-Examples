using UnityEngine;
using UnityEngine.UI;
using MinimumExample.iOS;

namespace MinimumExample
{
    sealed class Example : MonoBehaviour
    {
        [SerializeField] Button _buttonHelloWorld = default;

        void Start()
        {
            _buttonHelloWorld.onClick.AddListener(() =>
            {
                // プラグインの呼び出し
                var ret = ExampleBridge.PrintHelloWorld();
                Debug.Log($"戻り値: {ret}");
            });
        }
    }
}
