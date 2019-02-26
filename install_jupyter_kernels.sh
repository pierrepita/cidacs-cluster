pip install sparkmagic

jupyter nbextension enable --py --sys-prefix widgetsnbextension

# enter kernel location
cd `pip show sparkmagic | sed -n 's/Location: //p'`

jupyter-kernelspec install sparkmagic/kernels/pysparkkernel
jupyter-kernelspec install sparkmagic/kernels/sparkrkernel

jupyter serverextension enable --py sparkmagic

